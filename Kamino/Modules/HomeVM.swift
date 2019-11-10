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

enum CellType {
    case normal(value: String?, title: String)
    case interactive(value: String?)
}

final class HomeVM: ViewModel {
    
    struct Input {
        var load = PublishSubject<String>()
    }
    
    struct Output {
        var image: Observable<String?>
        var name: Observable<String?>
        var items: Observable<[SectionModel<String, CellType>]>
    }
    
    private let repo = HomeRepository()
    private let _planet = PublishSubject<Planet>()
    
    func transform(input: Input) -> Output {
        
        let planet = input.load.flatMapLatest { [weak self] url in
            return self?.repo.loadPlanet(id: 10) ?? Observable.empty()
        }.trackActivity(isLoaded)
        
        let sections = planet.map { pl in
            return [
                SectionModel(model: "Info", items: pl.data)
            ]
        }
        
        let image = planet.map { $0.imageUrl }
        let name = planet.map { $0.name }
        
        return Output(image: image, name: name, items: sections)
    }
}
