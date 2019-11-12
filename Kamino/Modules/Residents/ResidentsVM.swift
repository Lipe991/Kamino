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

final class ResidentsVM: ViewModel, ViewModelType {
    private let repo: ResidentsRepositoryProtocol
    private let _residents = BehaviorRelay<[Resident]>(value: [])
    var planet: Planet?
    
    // MARK: - Init
    init(with repo: ResidentsRepositoryProtocol, planet: Planet) {
        self.repo = repo
        super.init()
        self.planet = planet
    }
        
    // MARK: - ViewModelType
    func transform(from input: Input) -> Output {
        bindRetryLoad(input: input)
        bindLoadResident(with: input)
        let sections = _residents.map { residents in
            return [
                SectionModel(model: "", items: residents)
            ]
        }
        
        let image = input.load.map { $0.imageUrl }
        let name = input.load.map { String(format: "residents_navigation_title".localized, $0.name ?? "") }
        
        _residents.map { _ in return true }.bind(to: isLoaded).disposed(by: dispiseBag)
        
        return Output(image: image.asDriver(onErrorJustReturn: nil), name: name.asDriver(onErrorJustReturn: ""), items: sections.asDriver(onErrorJustReturn: []))
    }
    
    // MARK: - Helpers
    private func bindRetryLoad(input: Input) {
        input.retry.map { self.planet! }.bind(to: input.load).disposed(by: dispiseBag)
    }
    private func bindLoadResident(with input: Input) {
        input.load.flatMapLatest { [weak self] planet -> Observable<[Resident]> in
            guard let self = self else { return Observable<[Resident]>.empty() }
            self.isLoaded.accept(false)
            return self.repo.loadResidents(from: planet.residents ?? [])
        }.subscribe(onNext: { [weak self] (residents) in
            self?._residents.accept(residents)
            self?.onError.onNext(ErrorType.noError)
        }, onError: { [weak self] _ in
            self?.onError.onNext(ErrorType.error)
            self?.bindLoadResident(with: input)
        }).disposed(by: dispiseBag)

    }
}

extension ResidentsVM {
    struct Input: InputType {
        var retry = PublishSubject<Void>()
        var load = PublishSubject<Planet>()
    }
    
    struct Output: OutputType {
        var image: Driver<String?>
        var name: Driver<String>
        var items: Driver<[SectionModel<String, Resident>]>
    }
}
