//
//  MockLoader.swift
//  KaminoTests
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import Foundation

class MockLoader {
    static func load(from file: String, ext: String) -> String {
        do {
            let path = Bundle(for: MockLoader.self).path(forResource: file, ofType: ext)
            return try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch _ {
            fatalError("Error decoding file")
        }
    }
}
