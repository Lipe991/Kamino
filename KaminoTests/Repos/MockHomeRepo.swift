//
//  MockHomeRepo.swift
//  KaminoTests
//
//  Created by Sandi Mihelic on 12/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import RxSwift

@testable import Kamino

class MockHomeRepo: HomeRepositoryProtocol {
    func likePlanet(id: Int) -> Observable<Like> {
        return Observable.just(MockLoader.createLike())
    }
    
    func loadPlanet(id: Int) -> Observable<Planet> {
        return Observable.just(MockLoader.createPlanet())
    }
}
