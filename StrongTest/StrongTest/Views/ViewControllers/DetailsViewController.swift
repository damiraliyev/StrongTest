//
//  DetailsViewController.swift
//  StrongTest
//
//  Created by Damir Aliyev on 15.05.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var detailsViewModel: DetailViewModel?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: "Kazakhstan")
        return imageView
    }()
    
    let regionView = CharacteristicsView(characterictic: "Region:", value: "Asia")
    
    let capitalView = CharacteristicsView(characterictic: "Capital:", value: "Nur-Sultan")
    
    let capitalCoordinatesView = CharacteristicsView(characterictic: "Capital Coordinates:", value: "51.08, 71.26")
    
    let populationView = CharacteristicsView(characterictic: "Population:", value: "19 mln")
    
    let areaView = CharacteristicsView(characterictic: "Area:", value: "2 724 900 km^2")
    
    let currenciesView = CharacteristicsView(characterictic: "Currency:", value: "Tenge (KZT)")
    
    let timezonesView = CharacteristicsView(characterictic: "Timezones:", value: "GMT+6")
    
    let stack = makeStack(axis: .vertical, spacing: 40)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        if let viewModel = detailsViewModel {
            imageView.sd_setImage(with: URL(string: viewModel.flagURL))
            regionView.valueLabel.text = viewModel.region
            capitalView.valueLabel.text = viewModel.capitals
            capitalCoordinatesView.valueLabel.text = viewModel.capitalCoordinates
            populationView.valueLabel.text = viewModel.population
            areaView.valueLabel.text = viewModel.area
            currenciesView.valueLabel.text = viewModel.currencies
        }
        
        
    }
    
    private func layout() {
        view.addSubview(imageView)
        view.addSubview(stack)
        
        stack.addArrangedSubview(regionView)
        stack.addArrangedSubview(capitalView)
        stack.addArrangedSubview(capitalCoordinatesView)
        stack.addArrangedSubview(populationView)
        stack.addArrangedSubview(areaView)
        stack.addArrangedSubview(currenciesView)
        stack.addArrangedSubview(timezonesView)
        
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            stack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // сделано так, потому что это будет лучше выглядить на айпадах. Потому что там соотношение высоты и ширины
        // другое чем в телефонах
        imageView.heightAnchor.constraint(equalToConstant: imageView.frame.size.width / 1.75).isActive = true
    }
    
}
