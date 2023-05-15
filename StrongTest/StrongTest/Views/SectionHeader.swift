//
//  SectionHeader.swift
//  StrongTest
//
//  Created by Damir Aliyev on 15.05.2023.
//

import UIKit

class SectionHeader: UICollectionReusableView {
     var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .systemGray
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
         let attribute: [NSAttributedString.Key: Any] = [.kern: 2]
         let attributedString: NSAttributedString = NSMutableAttributedString(string: " ", attributes: attribute)
         label.attributedText = attributedString
         label.sizeToFit()
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(label)
         
         NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: self.rightAnchor)
         ])
         
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
