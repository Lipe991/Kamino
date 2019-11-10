//
//  ResidentMappingTest.swift
//  KaminoTests
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import XCTest

@testable import Kamino

class ResidentMappingTest: XCTestCase {
    
    private var jsonString = ""

    override func setUp() {
        jsonString = MockLoader.load(from: "resident", ext: "json")
    }

    func testResidentMapping() {
        let jsonData = jsonString.data(using: .utf8)!
        do {
            let resident = try JSONDecoder().decode(Resident.self, from: jsonData)
            
            XCTAssertEqual(resident.name, "Boba Fett")
            XCTAssertEqual(resident.height, "183")
            XCTAssertEqual(resident.mass, "78.2")
            XCTAssertEqual(resident.hairColor, "black")
            XCTAssertEqual(resident.skinColor, "fair")
            XCTAssertEqual(resident.eyeColor, "brown")
            XCTAssertEqual(resident.birthYear, "31.5BBY")
            XCTAssertEqual(resident.gender, "male")
            XCTAssertEqual(resident.homeworld, "http://private-84e428-starwars2.apiary-mock.com/planets/10")
            XCTAssertEqual(resident.homeworld, "http://private-84e428-starwars2.apiary-mock.com/planets/10")
            XCTAssertEqual(resident.imageUrl, "http://www.cinemablend.com/images/news_img/42742/star_wars_42742.jpg")

        } catch let error {
            fatalError(error.localizedDescription)

        }

    }

}
