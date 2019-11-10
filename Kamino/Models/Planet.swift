//
//  Planet.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

struct Planet {
    var name: String?
    var rotationPeriod: String?
    var orbitalPeriod: String?
    var diameter: String?
    var climate: String?
    var gravity: String?
    var terrain: String?
    var surfaceWater: String?
    var population: String?
    var residents: [String]?
    var imageUrl: String?
    var likes: Int?
}

// MARK: - Codable Planet

extension Planet: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case imageUrl = "image_url"
        case likes
    }
}

extension Planet {
    var data: [CellType] {
        return [
            .interactive(value: String(format: "home_residents_count".localized, residents?.count ?? 0)),
            .interactive(value: String(format: "home_like_count".localized, likes ?? 0)),
            .normal(value: rotationPeriod, title: "rotation_period_localization".localized),
            .normal(value: orbitalPeriod, title: "orbital_period_localization".localized),
            .normal(value: diameter, title: "diameter_localization".localized),
            .normal(value: climate, title: "climate_localization".localized),
            .normal(value: gravity, title: "gravity_localization".localized),
            .normal(value: terrain, title: "terrain_localization".localized),
            .normal(value: surfaceWater, title: "surface_water_localization".localized),
            .normal(value: population, title: "population_localization".localized)
        ]
    }
}
