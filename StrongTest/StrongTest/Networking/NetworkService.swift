//
//  NetworkService.swift
//  StrongTest
//
//  Created by Damir Aliyev on 14.05.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case serverError
    case decodingError
}

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchCountries(completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            print("data: ")
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
}
