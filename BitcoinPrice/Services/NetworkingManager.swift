//
//  NetworkingManager.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping (Result<T, NetworkError> ) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error ?? "")
                return
            }
            
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
        
    }
}
//
//func fetchData(from url: String) async await -> Currency {
//    
//    guard let url = URL(string: url) else {
//        throw NetworkError.invalidURL
//    }
//    
//    let (data, _) = try await URLSession.shared.data(from: url)
//    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .convertFromSnakeCase
//    let currencys: Currency
//    do {
//        currencys = try decoder.decode(Currency.self, from: data)
//    }
//    catch let error {
//        print(error.localizedDescription)
//        throw NetworkError.noData
//    }
//}
//}
