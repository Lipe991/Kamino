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

enum CellAction {
    case open
    case like
}

enum CellType {
    case normal(value: String?, title: String)
    case interactive(value: String?, type: CellAction)
}

final class HomeVM: ViewModel, ViewModelType {
    var planet: Planet?
    struct Input: InputType {
        var load = PublishSubject<String>()
        var like = PublishSubject<Void>()
    }

    struct Output: OutputType {
        typealias Item = CellType
        var image: Driver<String?>
        var name: Driver<String?>
        var items: Driver<[SectionModel<String, CellType>]>
    }

    private let repo = HomeRepository()
    private let _planet = BehaviorSubject<Planet?>(value: nil)
    var hasLiked: Bool = false

    func transform(from input: Input) -> Output {
        bindLoadPlanet(input: input)
        bindLikePlanet(input: input)
        let sections = _planet.compactMap { pl -> [SectionModel<String, CellType>] in
            guard let planet = pl else { return [] }
            return [
                SectionModel(model: "Info", items: planet.data)
            ]
        }.asDriver(onErrorJustReturn: [])

        let image = _planet.map { $0?.imageUrl }.asDriver(onErrorJustReturn: nil)
        let name = _planet.map { $0?.name }.asDriver(onErrorJustReturn: nil)

        _planet.subscribe(onNext: { [weak self] (planet) in
            self?.planet = planet
            self?.isLoaded.accept(true)
        }).disposed(by: self.dispiseBag)

        return Output(image: image, name: name, items: sections)
    }

    private func bindLoadPlanet(input: Input) {
        input.load.flatMapLatest { [weak self] _ -> Observable<Planet> in
            self?.isLoaded.accept(false)
            return self?.repo.loadPlanet(id: 10) ?? Observable<Planet>.empty()
        }.bind(to: _planet).disposed(by: dispiseBag)
    }

    private func bindLikePlanet(input: Input) {
        input.like.filter { !self.hasLiked }.flatMapLatest { [weak self] _ -> Observable<Like> in
            return self?.repo.likePlanet(id: 10) ?? Observable.empty()
        }.subscribe(onNext: { [weak self] (like) in
            guard let self = self, var planet = try? self._planet.value() else { return }
            // +1 so the value gets updated, since the server is returning value 10
            planet.likes = like.likes! + 1
            self._planet.onNext(planet)
            self.hasLiked = true
            }, onError: { [weak self] _ in
                self?.onError.onNext(ErrorType.error)
        }).disposed(by: dispiseBag)
    }
}
