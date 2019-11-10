//
//  HomeVM.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

enum CellType {
    case normal(value: String?, title: String)
    case interactive(value: String?)
}

final class HomeVM: ViewModel {
    var planet: Planet?
    struct Input {
        var load = PublishSubject<String>()
    }
    
    struct Output {
        var image: Driver<String?>
        var name: Driver<String?>
        var items: Driver<[SectionModel<String, CellType>]>
    }
    
    private let repo = HomeRepository()
    private let _planet = PublishSubject<Planet>()
    
    func transform(input: Input) -> Output {
        
        let planet = input.load.flatMapLatest { [weak self] url -> Observable<Planet> in
            self?.isLoaded.accept(false)
            return self?.repo.loadPlanet(id: 10) ?? Observable<Planet>.empty()
        }
        
        planet.subscribe(onError: { [weak self] (error) in
            guard let error = error as? ErrorType else { return }
            self?.onError.onNext(error)
        }).disposed(by: dispiseBag)

        
        let sections = planet.map { pl in
            return [
                SectionModel(model: "Info", items: pl.data)
            ]
        }.asDriver(onErrorJustReturn: [])
        
        let image = planet.map { $0.imageUrl }.asDriver(onErrorJustReturn: nil)
        let name = planet.map { $0.name }.asDriver(onErrorJustReturn: nil)
                
        planet.subscribe(onNext: { [weak self] (planet) in
            self?.planet = planet
            self?.isLoaded.accept(true)
        }).disposed(by: self.dispiseBag)
        
        return Output(image: image, name: name, items: sections)
    }
}
