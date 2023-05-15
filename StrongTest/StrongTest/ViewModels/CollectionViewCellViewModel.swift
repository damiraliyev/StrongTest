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
                
                str += "\(currency.name) (\(property.label?.uppercased() ?? "")), "
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
        //Округляю до 4 цифр, потому что у маленьких стран площадь отоброжались как 0
        return String((country.area / 1000000).rounded(toPlaces: 4)) + " mln km"
    }
    
    var longtitude: Double {
        return country.latlng[0]
    }
    
    var lattitude: Double {
        return country.latlng[1]
    }
    
    var population: String {
        //Округляю до 3 цифр, потому что страны с очень малым количеством населения отоброжались как 0
        return String( (Double(country.population) / 1000000).rounded(toPlaces: 3) ) + " mln"
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

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
