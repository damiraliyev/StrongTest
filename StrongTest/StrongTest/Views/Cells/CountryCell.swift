//
//  CountryCell.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

class CountryCell: UICollectionViewCell {
    static let reuseID = "CountryCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
