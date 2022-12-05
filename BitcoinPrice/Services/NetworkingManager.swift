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
    
    func fetchData(from url: String, completion: @escaping(Result<BtcRates, AFError> ) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON() { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let currency = value as? BtcRates else { return }
                    print(currency)
                    completion(.success(currency))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    private init() {}
}
