//
//  SkeletonCell.swift
//  StrongTest
//
//  Created by Damir Aliyev on 16.05.2023.
//

import UIKit

//
//  CountryCell.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

//extension SkeletonCell: SkeletonLoadable {}


class SkeletonCell: UICollectionViewCell, SkeletonLoadable {
    
    override var isSelected: Bool {
        didSet {
            animate()
        }
    }
    static let reuseID = "SkeletonCell"
    
//    override var isSelected: Bool {
//        didSet {
//            animate()
//        }
//    }
    
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
    
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.up")
        imageView.tintColor = .black
        
        return imageView
    }()
    
    let containerLayer = CAGradientLayer()
    
    let imageLayer = CAGradientLayer()
    let nameLayer = CAGradientLayer()
    let capitalLayer = CAGradientLayer()
    let chevronLayer = CAGradientLayer()
    
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
        setupLayers()
        setupAnimation()
        
    }

    private func layoutCell() {
        contentView.addSubview(container)
        
        container.addSubview(flagImageView)
        
        container.addSubview(nameCapitalStack)
        nameCapitalStack.addArrangedSubview(nameLabel)
        nameCapitalStack.addArrangedSubview(capitalLabel)
        
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
           
//            flagImageView.sd_setImage(with: URL(string: viewModel.flagURL))
            nameLabel.text = viewModel.name
            capitalLabel.text = viewModel.capital


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
        
        chevronLayer.startPoint = CGPoint(x: 0, y: 0.5)
        chevronLayer.endPoint = CGPoint(x: 1, y: 0.5)
        chevronImageView.layer.addSublayer(chevronLayer)
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
        
        let chevronGroup = makeAnimationGroup(previousGroup: capitalGroup)
        chevronLayer.add(chevronGroup, forKey: key)

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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageLayer.frame = flagImageView.bounds
        
        nameLayer.frame = nameLabel.bounds
        nameLayer.cornerRadius = nameLabel.bounds.height/2
        
        capitalLayer.frame = capitalLabel.bounds
        capitalLayer.cornerRadius = capitalLabel.bounds.height/2
        
    }
    
    
}
