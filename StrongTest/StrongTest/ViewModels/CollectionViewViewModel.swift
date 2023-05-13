//
//  CollectionViewViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

class CollectionViewViewModel {
    
    var countries: [Country] = []
    
    func numberOfRows() -> Int {
        return countries.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CollectionViewCellViewModel {
        let country = countries[indexPath.row]
        
        return CollectionViewCellViewModel(country: country)
    }
    
}
