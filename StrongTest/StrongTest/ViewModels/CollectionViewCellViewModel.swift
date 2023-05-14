//
//  CollectionViewCellViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

class CollectionViewCellViewModel {
    private let country: Country
    
    var name: String {
        return country.name.common
    }
    
    var currencies: String {
        var str = ""
        
        guard let curr = country.currencies else {
            return ""
        }
        
        for property in Mirror(reflecting: curr).children {
            if let currency = property.value as? Currency {
                print("\(property.label!) = \(currency)")
                str += currency.name + ", "
            }
        }
        
        return String(str.dropLast(2))
    }
    
    var capital: String {
        return country.capital?[0] ?? ""
    }
    
    var region: String {
        return country.region
    }
    
    var area: String {
        return String(country.area) + " mln km"
    }
    
    var longtitude: Double {
        return country.latlng[0]
    }
    
    var lattitude: Double {
        return country.latlng[1]
    }
    
    var population: String {
        return String(country.population) + " mln"
    }
    
    var timezones: [String] {
        return country.timezones
    }
    
    var flagURL: String {
        return country.flags.png
    }
    
    
    init(country: Country) {
        self.country = country
    }
}

