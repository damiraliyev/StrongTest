//
//  SkeletonCell.swift
//  StrongTest
//
//  Created by Damir Aliyev on 16.05.2023.
//

import UIKit

extension SkeletonCell: SkeletonLoadable {}


class SkeletonCell: UICollectionViewCell {
    
   
    static let reuseID = "SkeletonCell"
    
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
    
    let nameLabel = makeLabel(fontSize: 18, weight: .medium, text: "        ")
    
    let capitalLabel = makeLabel(fontSize: 14, color: .gray, weight: .regular, text: "      ")
    
    let nameCapitalStack = makeStack(axis: .vertical, spacing: 5)
    
    let populationLabel = makeBaseLabel()
    
    let areaLabel = makeBaseLabel()
    
    let currenciesLabel = makeBaseLabel()
    
    let characteristicsStack = makeStack(axis: .vertical, spacing: 10)
    
    let moreButton = makeButton(withText: "       ")
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.up")
        imageView.tintColor = .black
        
        return imageView
    }()

    
    let imageLayer = CAGradientLayer()
    let nameLayer = CAGradientLayer()
    let capitalLayer = CAGradientLayer()
    let populationLayer = CAGradientLayer()
    let areaLayer = CAGradientLayer()
    let currenciesLayer = CAGradientLayer()
    let buttonLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayers()
        setupAnimation()
        layoutCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupCell() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        clipsToBounds = true
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
            nameCapitalStack.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            characteristicsStack.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 16),
            characteristicsStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            characteristicsStack.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            moreButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            moreButton.topAnchor.constraint(equalTo: characteristicsStack.bottomAnchor, constant: 18),
            moreButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        NSLayoutConstraint.activate([
            chevronImageView.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
       
        chevronImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

    }
    
    weak var viewModel: CollectionViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                return
            }
        
            nameLabel.text = viewModel.name
            capitalLabel.text = viewModel.capital
            populationLabel.text = viewModel.population
            areaLabel.text = viewModel.area
            currenciesLabel.text = "    "
            
        }
    }
    
    private func setupLayers() {
        imageLayer.startPoint = CGPoint(x: 0, y: 0.5)
        imageLayer.endPoint = CGPoint(x: 1, y: 0.5)
        flagImageView.layer.addSublayer(imageLayer)

        nameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        nameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameLayer)

        capitalLayer.startPoint = CGPoint(x: 0, y: 0.5)
        capitalLayer.endPoint = CGPoint(x: 1, y: 0.5)
        capitalLabel.layer.addSublayer(capitalLayer)
        
        populationLayer.startPoint = CGPoint(x: 0, y: 0.5)
        populationLayer.endPoint = CGPoint(x: 1, y: 0.5)
        populationLabel.layer.addSublayer(populationLayer)
        
        areaLayer.startPoint = CGPoint(x: 0, y: 0.5)
        areaLayer.endPoint = CGPoint(x: 1, y: 0.5)
        areaLabel.layer.addSublayer(areaLayer)
        
        currenciesLayer.startPoint = CGPoint(x: 0, y: 0.5)
        currenciesLayer.endPoint = CGPoint(x: 1, y: 0.5)
        currenciesLabel.layer.addSublayer(currenciesLayer)
        
        buttonLayer.startPoint = CGPoint(x: 0, y: 0.5)
        buttonLayer.endPoint = CGPoint(x: 1, y: 0.5)
        moreButton.layer.addSublayer(buttonLayer)
    }
    
    private func setupAnimation() {
        let key = "backgroundColor"
        
        
        let imageGroup = makeAnimationGroup()
        imageGroup.beginTime = 0.0
        imageLayer.add(imageGroup, forKey: key)
        
        let nameGroup = makeAnimationGroup(previousGroup: imageGroup)
        nameLayer.add(nameGroup, forKey: key)
        
        let capitalGroup = makeAnimationGroup(previousGroup: nameGroup)
        capitalLayer.add(capitalGroup, forKey: key)
        
        let populationGroup = makeAnimationGroup(previousGroup: capitalGroup)
        populationLayer.add(populationGroup, forKey: key)
        
        let areaGroup = makeAnimationGroup(previousGroup: populationGroup)
        areaLayer.add(areaGroup, forKey: key)

        let currencyGroup = makeAnimationGroup(previousGroup: areaGroup)
        currenciesLayer.add(currencyGroup, forKey: key)
        
        let buttonGroup = makeAnimationGroup(previousGroup: currencyGroup)
        buttonLayer.add(buttonGroup, forKey: key)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.imageLayer.frame = self.flagImageView.bounds
            
            self.nameLayer.frame = self.nameLabel.bounds
            self.nameLayer.cornerRadius = self.nameLabel.bounds.height/2
            
            self.capitalLayer.frame = self.capitalLabel.bounds
            self.capitalLayer.cornerRadius = self.capitalLabel.bounds.height/2
            
            self.populationLayer.frame = self.populationLabel.bounds
            self.populationLayer.cornerRadius = self.populationLabel.bounds.height/2
            
            self.areaLayer.frame = self.areaLabel.bounds
            self.areaLayer.cornerRadius = self.areaLabel.bounds.height/2
            
            self.currenciesLayer.frame = self.currenciesLabel.bounds
            self.currenciesLayer.cornerRadius = self.currenciesLabel.bounds.height/2
            
            self.buttonLayer.frame = self.moreButton.bounds
            self.buttonLayer.cornerRadius = 8
            
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
