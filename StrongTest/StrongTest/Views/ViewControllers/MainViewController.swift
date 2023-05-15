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
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    var selectedIndexes: [IndexPath] = []

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
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        viewModel.fetchCountries { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        selectedIndexes.append(indexPath)
        collectionView.performBatchUpdates(nil)
        
        return true
    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectedIndexes.removeAll { iPath in
            indexPath == iPath
        }
        
        collectionView.performBatchUpdates(nil)
        
        return true
    }
}

//MARK: - CollectionViewDataSource methods
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            sectionHeader.label.text = viewModel.sectionTitle(for: indexPath)
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseID, for: indexPath) as! CountryCell
//        cell.animate()

        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        cell.cellDelegate = self
        return cell
    }
    
}

extension MainViewController: CountryCellDelegate {
    func learnMoreTapped(cca2: String) {
        
        
        viewModel.fetchCountry(cca2: cca2) {[weak self] result in
            switch result {
            case .success(let country):
                DispatchQueue.main.async {
                    let vc = DetailsViewController()
                    vc.detailsViewModel = DetailViewModel(country: country)
                    self?.navigationController?.pushViewController(vc, animated: true)
                    self?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                }
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: error.localizedDescription, message: "Could not load country details.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Done", style: .default))
                    self?.present(alertController, animated: true)
                }
                
            }
        }
//        navigationController?.pushViewController(vc, animated: true)
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        vc.title = cca2
    }
    
    
}

