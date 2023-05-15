//
//  CountryCell.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit
import SDWebImage

class CountryCell: UICollectionViewCell {
    static let reuseID = "CountryCell"
    
    override var isSelected: Bool {
        didSet {
            animate()
        }
    }
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        return view
    }()
    
    let flagImageView: UIImageView = {
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
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.up")
        imageView.tintColor = .black
        
        return imageView
    }()
    
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
        
        currenciesLabel.numberOfLines = 0
        
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
        
        container.addSubview(flagImageView)
        
        container.addSubview(nameCapitalStack)
        nameCapitalStack.addArrangedSubview(nameLabel)
        nameCapitalStack.addArrangedSubview(capitalLabel)
        
        container.addSubview(characteristicsStack)
        characteristicsStack.addArrangedSubview(populationLabel)
        characteristicsStack.addArrangedSubview(areaLabel)
        characteristicsStack.addArrangedSubview(currenciesLabel)
        
        container.addSubview(moreButton)
        
        container.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: container.topAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            nameCapitalStack.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor),
            nameCapitalStack.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 16),
            nameCapitalStack.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            characteristicsStack.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 16),
            characteristicsStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            characteristicsStack.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            moreButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            moreButton.topAnchor.constraint(equalTo: characteristicsStack.bottomAnchor, constant: 18)
        ])
        
        NSLayoutConstraint.activate([
            chevronImageView.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        //Некоторые названия стран очень длинные, из за этого они выходит поверх иконку. Чтобы осуществить
        // поведение чтобы навзание обрывалось троеточием, даем дополнительный констрейнт стэку:
        // nameCapitalStack.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -16)
        // Но в этом случае, иконка расплывется, если название страные не такое длинное
        // Из за этого увеличиваем huggin priority у иконки.
        chevronImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

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
           
            flagImageView.sd_setImage(with: URL(string: viewModel.flagURL))
            nameLabel.text = viewModel.name
            capitalLabel.text = viewModel.capital
            
            setAttributedTexts(
                populationString: viewModel.population,
                areaString: viewModel.area,
                currenciesString: viewModel.currencies
            )
//            print("weak var viewModel", viewModel.currencies[0])
        }
    }
    
    func animate() {
        UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.contentView.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * -0.999)
            self.chevronImageView.transform = self.isSelected ? upsideDown : .identity
        }
    }
}
