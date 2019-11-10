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
            .interactive(value: String(format: "home_residents_count".localized, residents?.count ?? 0), type: .open),
            .interactive(value: String(format: "home_like_count".localized, likes ?? 0), type: .like),
            .normal(value: rotationPeriod, title: "home_rotation_period_localization".localized),
            .normal(value: orbitalPeriod, title: "home_orbital_period_localization".localized),
            .normal(value: diameter, title: "home_diameter_localization".localized),
            .normal(value: climate, title: "home_climate_localization".localized),
            .normal(value: gravity, title: "home_gravity_localization".localized),
            .normal(value: terrain, title: "home_terrain_localization".localized),
            .normal(value: surfaceWater, title: "home_surface_water_localization".localized),
            .normal(value: population, title: "home_population_localization".localized)
        ]
    }
}
