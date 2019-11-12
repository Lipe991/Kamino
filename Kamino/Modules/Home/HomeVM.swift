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

final class HomeVM: ViewModel, ViewModelType {
    var hasLiked: Bool = false
    var planet: Planet? {
        return planetRelay.value
    }
    
    private let repo: HomeRepositoryProtocol
    private let planetRelay = BehaviorRelay<Planet?>(value: nil)
    
    // MARK: - Init
    init(with repo: HomeRepositoryProtocol) {
        self.repo = repo
        super.init()
    }
    
    // MARK: - ViewModelType
    func transform(from input: Input) -> Output {
        bindRetryLoad(input: input)
        bindLoadPlanet(input: input)
        bindLikePlanet(input: input)
        let sections = planetRelay.compactMap { pl -> [SectionModel<String, CellType>] in
            guard let planet = pl else { return [] }
            return [
                SectionModel(model: "", items: planet.data)
            ]
        }.asDriver(onErrorJustReturn: [])

        let image = planetRelay.map { $0?.imageUrl }.asDriver(onErrorJustReturn: nil)
        let name = planetRelay.map { $0?.name ?? "" }.asDriver(onErrorJustReturn: "")

        return Output(image: image, name: name, items: sections)
    }
    
    // MARK: - Helpers
    private func bindRetryLoad(input: Input) {
        input.retry.bind(to: input.load).disposed(by: dispiseBag)
        
        input.retry.subscribe(onNext: { (_) in
            input.load.onNext(())
        }).disposed(by: dispiseBag)

    }

    private func bindLoadPlanet(input: Input) {
        input.load.flatMapLatest { [weak self] _ -> Observable<Planet> in
            self?.isLoaded.accept(false)
            return self?.repo.loadPlanet(id: 10) ?? Observable<Planet>.empty()
        }.subscribe(onNext: { [weak self] (planet) in
            self?.planetRelay.accept(planet)
            self?.isLoaded.accept(true)
            self?.onError.onNext(.noError)
        }, onError: { [weak self] (error) in
            self?.onError.onNext(.error)
            self?.isLoaded.accept(true)
            self?.bindLoadPlanet(input: input)
        }).disposed(by: dispiseBag)
    }

    private func bindLikePlanet(input: Input) {
        input.like.filter { !self.hasLiked }.flatMapLatest { [weak self] _ -> Observable<Like> in
            return self?.repo.likePlanet(id: 10) ?? Observable.empty()
        }.subscribe(onNext: { [weak self] (like) in
            guard let self = self, var planet = self.planetRelay.value else { return }
            // +1 so the value gets updated, since the server is returning value 10
            planet.likes = like.likes! + 1
            self.planetRelay.accept(planet)
            self.hasLiked = true
            }, onError: { [weak self] _ in
                self?.onError.onNext(ErrorType.likeError)
        }).disposed(by: dispiseBag)
    }
}

extension HomeVM {
    struct Input: InputType {
        var retry = PublishSubject<Void>()
        var load = PublishSubject<Void>()
        var like = PublishSubject<Void>()
    }

    struct Output: OutputType {
        typealias Item = CellType
        var image: Driver<String?>
        var name: Driver<String>
        var items: Driver<[SectionModel<String, CellType>]>
    }
}
