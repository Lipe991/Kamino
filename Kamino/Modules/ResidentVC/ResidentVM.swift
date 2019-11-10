//
//  ResidentVM.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

final class ResidentVM: ViewModel {
    struct Input {
        var load = PublishSubject<Resident>()
    }
    
    struct Output {
        var image: Driver<String?>
        var name: Driver<String?>
        var items: Driver<[SectionModel<String, CellType>]>
    }
    
    private let repo = ResidentsRepository()
    private let _planet = PublishSubject<Planet>()
    
    func transform(input: Input) -> Output {
        
        let sections = input.load.map { resident in
            return [
                SectionModel(model: "Info", items: resident.data)
            ]
        }
        
        let image = input.load.map { $0.imageUrl }
        let name = input.load.map { $0.name }
        
        return Output(image: image.asDriver(onErrorJustReturn: nil), name: name.asDriver(onErrorJustReturn: nil), items: sections.asDriver(onErrorJustReturn: []))
    }
}
