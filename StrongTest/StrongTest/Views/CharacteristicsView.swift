//
//  CharacteristicsView.swift
//  StrongTest
//
//  Created by Damir Aliyev on 15.05.2023.
//

import UIKit

class CharacteristicsView: UIView {
    
    let dot = makeLabel(fontSize: 35, weight: .heavy, text: ".")
    let characteristicLabel = makeLabel(fontSize: 16, color: .systemGray, weight: .regular)
    let valueLabel = makeLabel(fontSize: 19, weight: .regular)
    let stack = makeStack(axis: .vertical, spacing: 5)
    
    
    init(characterictic: String, value: String = "", underlined: Bool = false) {
        super.init(frame: .zero)
        characteristicLabel.text = characterictic
        valueLabel.text = value
        
        if underlined {
            underlineValueLabel(text: value)
        }
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setup() {
        
        valueLabel.numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
    }
    
    private func layout() {
        addSubview(dot)
        addSubview(stack)
        stack.addArrangedSubview(characteristicLabel)
        stack.addArrangedSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            dot.leadingAnchor.constraint(equalTo: leadingAnchor),
            dot.lastBaselineAnchor.constraint(equalTo: centerYAnchor)
//            dot.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: dot.trailingAnchor, constant: 10),
            //Нужно было дать и trailing стороны, так как, если у страны два и больше валют, то они уйдут просто за экран
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func underlineValueLabel(text: String) {
        let underlineAttribute: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        valueLabel.attributedText = NSAttributedString(string: text, attributes: underlineAttribute)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 30)
    }
}
