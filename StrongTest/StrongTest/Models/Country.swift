//
//  Country.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import Foundation

struct Country: Codable {
    let name: Name?
    let currencies: [String: Currencies]?
    let capital: [String]?
    let region: String?
    let subregion: String?
    let area: Double?
    let population: Int?
    let timezones: [String]?
    let continents: [Continent]?
    let flags: Flags?
    let cca2: String?
    let capitalInfo: CapitalInfo?
    let maps: Map?
    
    static func makeSkeleton() -> Country {
        return Country(name: Name(common: "     "), currencies: nil, capital: ["     "], region: nil, subregion: nil, area: nil, population: nil, timezones: nil, continents: nil, flags: nil, cca2: nil, capitalInfo: nil, maps: nil)
    }
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
    case continent = "Continent"
}

// MARK: - Currencies
struct Currencies: Codable {
    let name: String?
    let symbol: String?
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
}

// MARK: - Name
struct Name: Codable {
    let common: String
}

enum Region: Codable {
    case africa
    case americas
    case antarctic
    case asia
    case europe
    case oceania
}


struct CapitalInfo: Codable {
    let latlng: [Double]?
}

struct Map: Codable {
    let openStreetMaps: String
}
