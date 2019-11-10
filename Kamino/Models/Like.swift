//
//  Like.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

struct Like {
    var planetId: Int?
    var likes: Int?
}

// MARK: - Codable
extension Like: Codable {
    enum CodingKeys: String, CodingKey {
        case planetId = "planet_id"
        case likes = "likes " // Seems like there is an error in the API? There is unecessery space in likes...
    }
}
