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
    private let _planet = PublishSubject<Planet>()
    
    func transform(input: Input) -> Output {
        
        let residents = input.load.flatMap { [weak self] planet in
            return self?.repo.loadResidents(from: planet.residents ?? []) ?? Observable.empty()
        }.trackActivity(isLoaded)
        
        let sections = residents.map { residents in
            return [
                SectionModel(model: "Residents", items: residents)
            ]
        }
        
        let image = input.load.map { $0.imageUrl }
        let name = input.load.map { $0.name }
        
        return Output(image: image.asDriver(onErrorJustReturn: nil), name: name.asDriver(onErrorJustReturn: nil), items: sections.asDriver(onErrorJustReturn: []))
    }

}
