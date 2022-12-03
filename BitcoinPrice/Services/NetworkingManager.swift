//
//  NetworkingManager.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchPerson(from url: String, completion: @escaping(Result<Any, AFError> ) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON() { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    private init() {}
}
