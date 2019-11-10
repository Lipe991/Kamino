//
//  ResidentsRepository.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class ResidentsRepository {
    private let disposeBag = DisposeBag()
    func loadResidents(from urls: [String]) -> Observable<[Resident]> {
        let urlObservables = urls.map { self.load(from: $0) }
        return Observable.combineLatest(urlObservables)
    }
    
    private func load(from url: String) -> Observable<Resident> {
        return Observable.create { observer in
            Alamofire.request(url, method: .get).responseData { (response) in
                if let data = response.data, let json = String(data: data, encoding: .utf8) {
                    do {
                        let jsonData = json.data(using: .utf8)!
                        let resident = try JSONDecoder().decode(Resident.self, from: jsonData)
                        observer.onNext(resident)
                    } catch let error {
                        observer.onError(PlanetRequestError.error)
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            return Disposables.create()
        }
    }
}
