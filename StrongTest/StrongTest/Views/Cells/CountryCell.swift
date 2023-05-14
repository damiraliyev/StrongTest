//
//  CountryCell.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

class CountryCell: UICollectionViewCell {
    static let reuseID = "CountryCell"
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Flag")
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 95).isActive = true
        return imageView
    }()
    
    let nameLabel = makeLabel(fontSize: 18, weight: .medium, text: "Kazakhstan")
    
    let capitalLabel = makeLabel(fontSize: 14, color: .gray, weight: .regular, text: "Astana")
    
    let nameCapitalStack = makeStack(axis: .vertical, spacing: 5)
    
    
    let populationLabel = makeBaseLabel()
    
    let areaLabel = makeBaseLabel()
    
    let currenciesLabel = makeBaseLabel()
    
    let characteristicsStack = makeStack(axis: .vertical, spacing: 10)
    
    let moreButton = makeButton(withText: "Learn more")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        layoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        clipsToBounds = true
        
        populationLabel.attributedText = makeAttributedText(characteristic: "Population: ", value: "19 mln")
        
        areaLabel.attributedText = makeAttributedText(characteristic: "Area: ", value: "2.725 mln km", power: 2)
        
        currenciesLabel.attributedText = makeAttributedText(characteristic: "Currencies: ", value: "Tenge (T) (KZT)")
        
        moreButton.setTitleColor(.link, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        
    }
    
    private func setAttributedTexts(populationString: String, areaString: String, currenciesString: String) {
        populationLabel.attributedText = makeAttributedText(characteristic: "Population: ", value: populationString)
        
        areaLabel.attributedText = makeAttributedText(characteristic: "Area: ", value: areaString, power: 2)
        
        currenciesLabel.attributedText = makeAttributedText(characteristic: "Currencies: ", value: currenciesString)
    }
    
    private func layoutCell() {
        contentView.addSubview(container)
        
        container.addSubview(imageView)
        
        container.addSubview(nameCapitalStack)
        nameCapitalStack.addArrangedSubview(nameLabel)
        nameCapitalStack.addArrangedSubview(capitalLabel)
        
        container.addSubview(characteristicsStack)
        characteristicsStack.addArrangedSubview(populationLabel)
        characteristicsStack.addArrangedSubview(areaLabel)
        characteristicsStack.addArrangedSubview(currenciesLabel)
        
        container.addSubview(moreButton)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            nameCapitalStack.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            nameCapitalStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            characteristicsStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            characteristicsStack.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            moreButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            moreButton.topAnchor.constraint(equalTo: characteristicsStack.bottomAnchor, constant: 24)
        ])

    }
    
    private func makeAttributedText(characteristic: String, value: String, power: Int? = nil) -> NSAttributedString {
        let characteristicsAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.systemGray
        ]
        
        let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body)
        ]
        
        let rootString = NSMutableAttributedString(string: characteristic, attributes: characteristicsAttributes)
        let valueString = NSAttributedString(string: value, attributes: valueAttributes)
        rootString.append(valueString)
        
        if let power = power {
            let powerAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.preferredFont(forTextStyle: .footnote),
                .baselineOffset: 8
            ]
            let powerString = NSAttributedString(string: String(power), attributes: powerAttributes)
            rootString.append(powerString)
        }
        
        return rootString
    }
    
    weak var viewModel: CollectionViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                return
            }
            imageView.image = UIImage(named: viewModel.name)
            nameLabel.text = viewModel.name
            capitalLabel.text = viewModel.capital
            
            setAttributedTexts(
                populationString: viewModel.population,
                areaString: viewModel.area,
                currenciesString: viewModel.currencies
            )
        }
    }


}
