//
//  HomeRepository.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol HomeRepositoryType {
    func loadPlanet(id: Int) -> Observable<Planet>
}

enum PlanetRequestError: Error {
    case error
}

final class HomeRepository: HomeRepositoryType {
    func loadPlanet(id: Int) -> Observable<Planet> {
        return Observable.create { observer in            Alamofire.request("https://private-anon-11f41d95d7-starwars2.apiary-mock.com/planets/10", method: .get).responseData { (response) in
                if let data = response.data, let json = String(data: data, encoding: .utf8) {
                    do {
                        let jsonData = json.data(using: .utf8)!
                        let planet = try JSONDecoder().decode(Planet.self, from: jsonData)
                        observer.onNext(planet)
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
