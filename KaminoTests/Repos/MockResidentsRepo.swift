//
//  MockResidentsRepo.swift
//  KaminoTests
//
//  Created by Sandi Mihelic on 12/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import RxSwift

@testable import Kamino

class MockResidentsRepo: ResidentsRepositoryProtocol {
    func loadResidents(from urls: [String]) -> Observable<[Resident]> {
        return Observable.create { observer in
            observer.onNext([MockLoader.createResident()])
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
