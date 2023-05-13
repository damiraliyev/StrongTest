//
//  Factory.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

func makeLabel(fontSize: CGFloat, color: UIColor? = nil, weight: UIFont.Weight, text: String? = nil) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    
    if let color = color {
        label.textColor = color
    }
    
    if let text = text {
        label.text = text
    }
    
    return label
}

func makeBaseLabel() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
}

func makeStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = axis
    stackView.spacing = spacing
    
    return stackView
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    
    return button
}
