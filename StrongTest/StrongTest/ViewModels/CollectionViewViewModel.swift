//
//  CollectionViewViewModel.swift
//  StrongTest
//
//  Created by Damir Aliyev on 13.05.2023.
//

import UIKit

class CollectionViewViewModel {
    
    var countries: [Country] = [

    ]
    
    
    var africaCountries: [Country] = []
    var antarcticaCountries: [Country] = []
    var asiaCountries: [Country] = []
    var europeCountries: [Country] = []
    var northAmericaCountries: [Country] = []
    var oceniaCountries: [Country] = []
    var southAmericaCountries: [Country] = []

    
    var sectionTitles: [Continent] = [Continent.continent]
 
    func numberOfSections() -> Int {
        return sectionTitles.count
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        switch section {
        case 0: return africaCountries.count
        case 1: return antarcticaCountries.count
        case 2: return asiaCountries.count
        case 3: return europeCountries.count
        case 4: return northAmericaCountries.count
        case 5: return oceniaCountries.count
        case 6: return southAmericaCountries.count
        default:
            return 0
        }
    }
    
    
    
    func cellViewModel(for indexPath: IndexPath) -> CollectionViewCellViewModel {

        switch indexPath.section {
        case 0:
            print("SECTION 0")
            return CollectionViewCellViewModel(country: africaCountries[indexPath.row])
        case 1: return CollectionViewCellViewModel(country: antarcticaCountries[indexPath.row])
        case 2: return CollectionViewCellViewModel(country: asiaCountries[indexPath.row])
        case 3: return CollectionViewCellViewModel(country: europeCountries[indexPath.row])
        case 4: return CollectionViewCellViewModel(country: northAmericaCountries[indexPath.row])
        case 5: return CollectionViewCellViewModel(country: oceniaCountries[indexPath.row])
        case 6: return CollectionViewCellViewModel(country: southAmericaCountries[indexPath.row])
        default:
            return CollectionViewCellViewModel(country: Country(name: Name(common: "   "), currencies: nil, capital: nil, region: "", subregion: "", latlng: [], area: 0, population: 0, timezones: [], continents: [], flags: Flags(png: ""), cca2: "", capitalInfo: nil, maps: nil))
        }

    }
    
    func sectionTitle(for indexPath: IndexPath) -> String {
        return sectionTitles[indexPath.section].rawValue.uppercased()
    }
    
    func fetchCountries(completion: @escaping (Bool) -> Void) {
        NetworkService.shared.fetchCountries { [weak self] result in
            
            switch result {
            case .success(let countries):
                // Мне это нужно чтобы с помощью indexPath добыть доступ к любой стране стране
                self?.countries = countries
                
                //очистить этот массив, так как мы его использовали для скелетонов
                self?.africaCountries = []
                for country in countries {
                    guard let continent = country.continents?[0] else {
                        continue
                    }
                    switch continent {
                    case .africa:
                        self?.africaCountries.append(country)
                    case .antarctica:
                        self?.antarcticaCountries.append(country)
                    case .asia:
                        self?.asiaCountries.append(country)
                    case .europe:
                        self?.europeCountries.append(country)
                    case .northAmerica:
                        self?.northAmericaCountries.append(country)
                    case .oceania:
                        self?.oceniaCountries.append(country)
                    case .southAmerica:
                        self?.southAmericaCountries.append(country)
                    case .continent:
                        continue
                    }
        
                }
                self?.sectionTitles = [
                    Continent.africa,
                    Continent.antarctica,
                    Continent.asia,
                    Continent.europe,
                    Continent.northAmerica,
                    Continent.oceania,
                    Continent.southAmerica
                ]
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func fetchCountry(cca2: String, completion: @escaping (Result<Country, NetworkError>) -> Void) {
        NetworkService.shared.fetchCountry(cca2: cca2) { result in
            switch result {
            case .success(let country):
                completion(.success(country))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func setCountriesForSkeletons() {
        let row = Country.makeSkeleton()
        
        self.africaCountries = Array(repeating: row, count: 10)
    }
}
