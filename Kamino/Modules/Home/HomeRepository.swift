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

final class HomeRepository {
    func loadPlanet(id: Int) -> Observable<Planet> {
        return Observable.create { observer in            Alamofire.request(Managers.Request.planet(id: id).build(), method: .get).responseData { (response) in
                if let data = response.data, let json = String(data: data, encoding: .utf8) {
                    do {
                        let jsonData = json.data(using: .utf8)!
                        let planet = try JSONDecoder().decode(Planet.self, from: jsonData)
                        observer.onNext(planet)
                        observer.onCompleted()
                    } catch let error {
                        observer.onError(ErrorType.error)
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            return Disposables.create()
        }
    }

    func likePlanet(id: Int) -> Observable<Like> {
        return Observable.create { observer in
            Alamofire.request(Managers.Request.like(id: id).build(), method: .post).responseData { (response) in
                if let data = response.data, let json = String(data: data, encoding: .utf8) {
                    do {
                        let jsonData = json.data(using: .utf8)!
                        let like = try JSONDecoder().decode(Like.self, from: jsonData)
                        observer.onNext(like)
                        observer.onCompleted()
                    } catch let error {
                        observer.onError(ErrorType.error)
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            return Disposables.create()
        }
    }
}
