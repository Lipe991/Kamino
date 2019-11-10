//
//  LikeMappingTest.swift
//  KaminoTests
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Kamino

class LikeMappingTest: XCTestCase {

    private var jsonString = ""

    override func setUp() {
        jsonString = MockLoader.load(from: "like", ext: "json")
    }

    func testLikeMapping() {
        let jsonData = jsonString.data(using: .utf8)!
        let like = try! JSONDecoder().decode(Like.self, from: jsonData)
        
        XCTAssertEqual(like.planetId, 10)
        XCTAssertEqual(like.likes, 10)
    }    
}
