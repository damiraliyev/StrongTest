//
//  Extensions.swift
//  StrongTest
//
//  Created by Damir Aliyev on 15.05.2023.
//

import UIKit

extension String {
    func addPower(power: Int) -> NSMutableAttributedString {
        let powerAttributes: [NSAttributedString.Key: Any] = [.baselineOffset: 8, .font: UIFont.preferredFont(forTextStyle: .callout)]
        let powerText = NSAttributedString(string: String(power), attributes: powerAttributes)
        let root = NSMutableAttributedString(string: self)
        root.append(powerText)
        return root
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
