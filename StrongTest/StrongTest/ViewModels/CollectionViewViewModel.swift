//
//  CollectionViewViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

class CollectionViewViewModel {
    
    var countries: [Country] = [
        Country(name: "Kazakhstan", currencies: ["T"], capital: "Nur-Sultan", region: "Asia", area: 2.725, coordinates: [51.08, 71.26], population: 19, timezones: ["GMT+6"]),
        Country(name: "France", currencies: ["T"], capital: "Paris", region: "Europe", area: 0.64, coordinates: [48.51, 2.21], population: 68, timezones: ["GMT+1"])
    ]
    
    func numberOfRows() -> Int {
        return countries.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CollectionViewCellViewModel {
        let country = countries[indexPath.row]
        
        return CollectionViewCellViewModel(country: country)
    }
    
}
