//
//  MainViewController.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewModel = CollectionViewViewModel()
    
    let sectionInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var selectedIndexes: [IndexPath] = [IndexPath(row: 0, section: 0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        title = "World Countries"
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: CountryCell.reuseID)
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

//MARK: - CollectionViewDelegate methods
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 1
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        if selectedIndexes.contains(indexPath) {
            return CGSize(width: widthPerItem, height: 250)
        } else {
            // Image height(55) + 12 padding from top + 12 padding from bottom
            return CGSize(width: widthPerItem, height: 79)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: sectionInsets.left, bottom: 15, right: sectionInsets.right)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath) {
            selectedIndexes.removeAll { iPath in
                indexPath == iPath
            }
        } else {
            selectedIndexes.append(indexPath)
        }
        
        collectionView.performBatchUpdates(nil)
    }
}

//MARK: - CollectionViewDataSource methods
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseID, for: indexPath) as! CountryCell
        cell.animate()
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        
        return cell
    }
    
    
}

