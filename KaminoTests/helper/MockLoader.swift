//
//  MockLoader.swift
//  KaminoTests
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation

@testable import Kamino

class MockLoader {
    static func load(from file: String, ext: String) -> String {
        do {
            let path = Bundle(for: MockLoader.self).path(forResource: file, ofType: ext)
            return try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch _ {
            fatalError("Error decoding file")
        }
    }
    
    static func createResident() -> Resident {
        let jsonString = MockLoader.load(from: "resident", ext: "json")
        let jsonData = jsonString.data(using: .utf8)!
        do {
            let resident = try JSONDecoder().decode(Resident.self, from: jsonData)
            return resident
        } catch _ {
            fatalError("Error maping")
        }

    }
    
    static func createPlanet() -> Planet {
        let jsonString = MockLoader.load(from: "planet", ext: "json")
        let jsonData = jsonString.data(using: .utf8)!
        do {
            let planet = try JSONDecoder().decode(Planet.self, from: jsonData)
            return planet
        } catch _ {
            fatalError("Error maping")
        }
    }
    
    static func createLike() -> Like {
        let jsonString = MockLoader.load(from: "like", ext: "json")
        let jsonData = jsonString.data(using: .utf8)!
        do {
            let like = try JSONDecoder().decode(Like.self, from: jsonData)
            return like
        } catch _ {
            fatalError("Error maping")
        }
    }

}
