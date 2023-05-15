//
//  DetailViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 15.05.2023.
//


class DetailViewModel {
    let country: Country
    
    var flagURL: String {
        return country.flags.png
    }
    
    var region: String {
        return country.region
    }
    
    var capitals: String {
        return String(country.capital?[0] ?? "")
    }

    var capitalCoordinates: String {
        return String(country.latlng[0]) + ", " + String(country.latlng[1])
    }
    
    var population: String {
        return String(country.population)
    }
    
    var area: String {
        return String(country.area) + "km^2"
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
    
    var timezones: String {
        var tmz = ""
        
        for timezone in country.timezones {
            tmz += timezone + ", "
        }
        
        return String(tmz.dropLast(2))
    }
    
    init(country: Country) {
        self.country = country
    }
}
