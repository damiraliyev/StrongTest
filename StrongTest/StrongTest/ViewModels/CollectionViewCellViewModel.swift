//
//  CollectionViewCellViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

class CollectionViewCellViewModel {
    private let country: Country
    
    var name: String {
        return country.name
    }
    
    var currencies: String {
        return country.currencies[0]
    }
    
    var capital: String {
        return country.capital
    }
    
    var region: String {
        return country.region
    }
    
    var area: String {
        return String(country.area) + " mln km"
    }
    
    var longtitude: Float {
        return country.coordinates[0]
    }
    
    var lattitude: Float {
        return country.coordinates[1]
    }
    
    var population: String {
        return String(country.population) + " mln"
    }
    
    var timezones: [String] {
        return country.timezones
    }
    
    
    init(country: Country) {
        self.country = country
    }
}

