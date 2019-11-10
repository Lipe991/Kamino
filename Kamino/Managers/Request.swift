//
//  Request.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation


extension Managers {
    enum Request {
        case planet(id: Int)
        case like(id: Int)
        
        private var baseUrl: String {
            return "https://private-anon-11f41d95d7-starwars2.apiary-mock.com/"
        }
        
        func build() -> String {
            switch self {
            case .planet(let id): return baseUrl + "planets/\(id)"
            case .like(let id): return baseUrl + "planets/\(id)/like"
            }
        }
    }
}
