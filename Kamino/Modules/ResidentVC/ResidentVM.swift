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

final class ResidentVM: ViewModel, ViewModelType {
    struct Input: InputType {
        var retry = PublishSubject<Void>()
        var load = PublishSubject<Resident>()
    }
    
    struct Output: OutputType {
        var image: Driver<String?>
        var name: Driver<String>
        var items: Driver<[SectionModel<String, CellType>]>
    }
    
    var resident: Resident?
    
    // MARK: - Init
    init(with resident: Resident) {
        super.init()
        self.resident = resident
    }
        
    // MARK: - ViewModelType
    func transform(from input: Input) -> Output {
        
        let sections = input.load.map { resident in
            return [
                SectionModel(model: "", items: resident.data)
            ]
        }
        
        let image = input.load.map { $0.imageUrl }
        let name = input.load.map { $0.name ?? "" }
        
        input.load.map { _ in return true }.bind(to: isLoaded).disposed(by: dispiseBag)
        
        return Output(image: image.asDriver(onErrorJustReturn: nil), name: name.asDriver(onErrorJustReturn: ""), items: sections.asDriver(onErrorJustReturn: []))
    }
}
