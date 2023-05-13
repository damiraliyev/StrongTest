//
//  CollectionViewViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

class CollectionViewViewModel {
    
    var countries: [Country] = [
        Country(name: "Kazakhstan", currencies: ["T"], capital: "Nur-Sultan", region: "Asia", area: 2.725, coordinates: [51.08, 71.26], population: 19, timezones: ["GMT+6"])
    ]
    
    func numberOfRows() -> Int {
        return countries.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CollectionViewCellViewModel {
        let country = countries[indexPath.row]
        
        return CollectionViewCellViewModel(country: country)
    }
    
}
