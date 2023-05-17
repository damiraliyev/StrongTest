//
//  DetailsViewController.swift
//  StrongTest
//
//  Created by Damir Aliyev on 15.05.2023.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {
    
    var detailsViewModel: DetailViewModel?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8

        return imageView
    }()
    
    let regionView = CharacteristicsView(characterictic: "Region:")
    
    let capitalView = CharacteristicsView(characterictic: "Capital:")
    
    let capitalCoordinatesView = CharacteristicsView(characterictic: "Capital Coordinates:", underlined: true)
    
    let populationView = CharacteristicsView(characterictic: "Population:")
    
    let areaView = CharacteristicsView(characterictic: "Area:")
    
    let currenciesView = CharacteristicsView(characterictic: "Currency:")
    
    let timezonesView = CharacteristicsView(characterictic: "Timezones:")
    
    let stack = makeStack(axis: .vertical, spacing: 20)
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = self.view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        
        return contentView
    }()

    
    var contentSize: CGSize {
        CGSize(width: self.view.frame.width, height: self.view.frame.height + 50)
    }
    
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
            capitalView.valueLabel.text = viewModel.capital
            capitalCoordinatesView.valueLabel.text = viewModel.capitalCoordinates
            populationView.valueLabel.text = viewModel.population
            areaView.valueLabel.attributedText = viewModel.area.addPower(power: 2)
            currenciesView.valueLabel.text = viewModel.currencies
            timezonesView.valueLabel.text = viewModel.timezones
        }
        
        addGestureRecognizers()
    }
    
    
    func addGestureRecognizers() {
        capitalCoordinatesView.valueLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openMap))
        capitalCoordinatesView.valueLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func openMap() {
        
        guard let viewModel = detailsViewModel,
              let url = URL(string: viewModel.mapURL) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    private func layout() {
        view.addSubview(scrollView)

        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(stack)
        
        stack.addArrangedSubview(regionView)
        stack.addArrangedSubview(capitalView)
        stack.addArrangedSubview(capitalCoordinatesView)
        stack.addArrangedSubview(populationView)
        stack.addArrangedSubview(areaView)
        stack.addArrangedSubview(currenciesView)
        stack.addArrangedSubview(timezonesView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: (view.frame.size.width - 32) / 1.75)
        ])

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            stack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            if self.stack.frame.maxY + 100 < self.view.frame.maxY {
                self.scrollView.isScrollEnabled = false
            } else {
                let height = self.stack.frame.maxY + 50
                self.contentView.frame.size = CGSize(width: self.view.frame.width, height: height)
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
            }
        }
        
    }

    
    
}
