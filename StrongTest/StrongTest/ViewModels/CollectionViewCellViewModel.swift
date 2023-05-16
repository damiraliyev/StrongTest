//
//  CollectionViewCellViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import Foundation

class CollectionViewCellViewModel {
    private let country: Country
    
    var name: String {
        return country.name?.common ?? ""
    }
    
    var currencies: String {
        var str = ""
        
        guard let curr = country.currencies else {
            return ""
        }
        
        for property in Mirror(reflecting: curr).children {
            if let currency = property.value as? Currency {
                print("\(property.label!) = \(currency)")
                
                str += "\(currency.name) (\(property.label?.uppercased() ?? "")), "
            }
        }
        
        return String(str.dropLast(2))
    }
    
    var capital: String {
        return String(country.capital?[0] ?? "")
    }
    
    var region: String {
        return country.region ?? ""
    }
    
    
    var area: String {
        let unwrapped = country.area ?? 0
        if unwrapped > 99999 {
            return String((unwrapped / 1000000).rounded(toPlaces: 2)) + " mln km"
        } else {
            return String(Int(unwrapped)) + " km"
        }
    }


    var population: String {
        let unwrapped = country.population ?? 0
        if unwrapped > 99999 {
            return String( (Double(unwrapped) / 1000000).rounded(toPlaces: 2) ) + " mln"
        } else {
            return String(unwrapped)
        }
        
    }
    
    var timezones: [String] {
        return country.timezones ?? []
    }
    
    var flagURL: String {
        return country.flags?.png ?? ""
    }
    
    var cca2: String {
        return country.cca2 ?? ""
    }
    
    init(country: Country) {
        self.country = country
    }
}
