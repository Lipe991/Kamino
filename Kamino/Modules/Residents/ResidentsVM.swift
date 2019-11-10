//
//  ResidentsVM.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

final class ResidentsVM: ViewModel {
    struct Input {
        var load = PublishSubject<Planet>()
    }
    
    struct Output {
        var image: Driver<String?>
        var name: Driver<String?>
        var items: Driver<[SectionModel<String, Resident>]>
    }
    
    private let repo = ResidentsRepository()
    private let _residents = PublishSubject<[Resident]>()
    
    func transform(input: Input) -> Output {
        
        input.load.flatMapLatest { [weak self] planet -> Observable<[Resident]> in
            guard let self = self else { return Observable<[Resident]>.empty() }
            self.isLoaded.accept(false)
            return self.repo.loadResidents(from: planet.residents ?? [])
        }.bind(to: _residents).disposed(by: dispiseBag)
        
        _residents.subscribe(onError: { [weak self] (error) in
            guard let error = error as? ErrorType else { return }
            self?.onError.onNext(error)
        }).disposed(by: dispiseBag)
        
        let sections = _residents.map { residents in
            return [
                SectionModel(model: "Residents", items: residents)
            ]
        }
        
        let image = input.load.map { $0.imageUrl }
        let name = input.load.map { $0.name }
        
        _residents.map { _ in return true }.bind(to: isLoaded).disposed(by: dispiseBag)
        
        return Output(image: image.asDriver(onErrorJustReturn: nil), name: name.asDriver(onErrorJustReturn: nil), items: sections.asDriver(onErrorJustReturn: []))
    }
}
