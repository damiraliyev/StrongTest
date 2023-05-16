//
//  DetailViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 15.05.2023.
//


class DetailViewModel {
    let country: Country
    
    var flagURL: String {
        return country.flags?.png ?? ""
    }
    
    var region: String {
        return country.subregion ?? ""
    }
    
    var capital: String {
        return String(country.capital?[0] ?? "")
    }

    var capitalCoordinates: String {
        guard let latlng = country.capitalInfo?.latlng else {
            return ""
        }
        let lat = String(latlng[0]).replacingOccurrences(of: ".", with:  "°") + "'"
        let lng = String(latlng[1]).replacingOccurrences(of: ".", with:  "°") + "'"
        return lat + ", " + lng
    }
    
    var population: String {
        let unwrapped = country.population ?? 0
        if unwrapped > 99999 {
            return String( (Double(unwrapped) / 1000000).rounded(toPlaces: 2) ) + " mln"
        } else {
            return String(unwrapped)
        }
    }
    
    var area: String {
        let unwrapped = country.area ?? 0
        if unwrapped > 99999 {
            return String(((unwrapped) / 1000000).rounded(toPlaces: 2)) + " mln km"
        } else {
            return String(Int(unwrapped)) + " km"
        }
    }
    
    var currencies: String {
        var str = ""
        
        guard let curr = country.currencies else {
            return ""
        }
        
        for property in Mirror(reflecting: curr).children {
            if let currency = property.value as? Currency {
                print("\(property.label!) = \(currency)")
                
                str += "\(currency.name) (\(property.label?.uppercased() ?? "")) \n"
            }
        }
        
        return String(str.dropLast(2))
    }
    
    var timezones: String {
        var tmz = ""
        guard let timezones = country.timezones else {
            return ""
        }
        for timezone in timezones {
            tmz += timezone + ", "
        }
        
        return String(tmz.dropLast(2))
    }
    
    var mapURL: String {
        return country.maps?.openStreetMaps ?? ""
    }
    
    init(country: Country) {
        self.country = country
    }
}
