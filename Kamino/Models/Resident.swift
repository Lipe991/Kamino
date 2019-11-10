//
//  Resident.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

struct Resident {
    var name: String?
    var height: String?
    var mass: String?
    var hairColor: String?
    var skinColor: String?
    var eyeColor: String?
    var birthYear: String?
    var gender: String?
    var homeworld: String?
    var imageUrl: String?
}

// MARK: - Codable
extension Resident: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
        case imageUrl = "image_url"
    }
}

extension Resident {
    var data: [CellType] {
        return [
            .normal(value: name, title: "resident_name_localization".localized),
            .normal(value: height, title: "resident_height_localization".localized),
            .normal(value: mass, title: "resident_mass_localization".localized),
            .normal(value: hairColor, title: "resident_hair_color_localization".localized),
            .normal(value: skinColor, title: "resident_skin_color_localization".localized),
            .normal(value: eyeColor, title: "resident_eye_color_localization".localized),
            .normal(value: birthYear, title: "resident_birth_year_localization".localized),
            .normal(value: gender, title: "resident_gender_localization".localized)
        ]
    }
}
