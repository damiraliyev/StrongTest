//
//  MainViewController.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewModel = CollectionViewViewModel()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        layout()
    }
    
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: CountryCell.reuseID)
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

//MARK: - CollectionViewDelegate methods
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
}

//MARK: - CollectionViewDataSource methods
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseID, for: indexPath) as! CountryCell
        
        return cell
    }
    
    
}

