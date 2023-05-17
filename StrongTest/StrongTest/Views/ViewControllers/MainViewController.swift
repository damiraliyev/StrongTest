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
    
    private var selectedIndexes: [IndexPath] = []
    
    private var isLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        title = "World Countries"
        
        UNUserNotificationCenter.current().delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: CountryCell.reuseID)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(SkeletonCell.self, forCellWithReuseIdentifier: SkeletonCell.reuseID)
        setupSkeletons()
//
//        viewModel.fetchCountries { [weak self] success in
//            if success {
//                DispatchQueue.main.async {
//                    self?.isLoaded = true
//                    self?.pushNotificationIfAllowed()
//                    self?.collectionView.reloadData()
//                }
//            }
//        }
    }
    
    private func setupSkeletons() {
        viewModel.setCountriesForSkeletons()
        collectionView.reloadData()
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
    
    func fetchCountry(cca2: String) {
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
            let height = viewModel.heightOfSelectedItem(indexPath: indexPath)
            return CGSize(width: widthPerItem, height: height)
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

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if !isLoaded {
            return false
        }
        
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
        if !isLoaded {
            return 1
        }
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
         
        if isLoaded {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseID, for: indexPath) as! CountryCell
            cell.viewModel = viewModel.cellViewModel(for: indexPath)
            cell.cellDelegate = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel

        return cell
        
    }
    
}


extension MainViewController: CountryCellDelegate {
    func learnMoreTapped(cca2: String) {
        fetchCountry(cca2: cca2)
    }
}


//MARK: - Notifications
extension MainViewController {
    
    func pushNotificationIfAllowed() {
        PushNotification.shared.checkForPermission { [weak self] granted in
            if granted {
                self?.viewModel.getRandomCountry(completion: { name, capital, cca2 in
                    PushNotification.shared.dispatchNotification(
                        name: name,
                        capital: capital,
                        cca2: cca2
                    )
                })
            }
        }
    }
}


//MARK: - UNUserNotificationCenterDelegate
extension MainViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.banner)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        guard let country = viewModel.randomCountry else {
            return
        }
        fetchCountry(cca2: country.cca2 ?? "")
    }
    
}
