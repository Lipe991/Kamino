//
//  PlanetMappingTest.swift
//  KaminoTests
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import XCTest
@testable import Kamino

class PlanetMappingTests: XCTestCase {
    
    private var jsonString = ""

    override func setUp() {
        jsonString = MockLoader.load(from: "planet", ext: "json")
    }

    func testPlanetMapping() {
        let jsonData = jsonString.data(using: .utf8)!
        let planet = try! JSONDecoder().decode(Planet.self, from: jsonData)
        
        XCTAssertEqual(planet.name, "Kamino")
        XCTAssertEqual(planet.rotationPeriod, "27")
        XCTAssertEqual(planet.diameter, "19720")
        XCTAssertEqual(planet.climate, "temperate")
        XCTAssertEqual(planet.gravity, "1 standard")
        XCTAssertEqual(planet.terrain, "ocean")
        XCTAssertEqual(planet.surfaceWater, "100")
        XCTAssertEqual(planet.population, "1000000000")
        XCTAssertEqual(planet.residents?.count, 48)
        XCTAssertEqual(planet.imageUrl, "http://vignette4.wikia.nocookie.net/starwars/images/a/a9/Eaw_Kamino.jpg/revision/latest?cb=20090527045541")
        XCTAssertEqual(planet.likes, 10)
    }
}
