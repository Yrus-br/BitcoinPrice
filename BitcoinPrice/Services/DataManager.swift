//
//  DataManager.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

import UIKit

class DataManager {
    static let shared = DataManager()
    
    let cryptoImage = [
        UIImage(named: "bitcoin"),
        UIImage(named: "eth"),
        UIImage(named: "litecoin"),
        UIImage(named: "btccash"),
        UIImage(named: "bnb"),
        UIImage(named: "eos"),
        UIImage(named: "xrp"),
        UIImage(named: "xlm.icon"),
        UIImage(named: "chainlink"),
        UIImage(named: "dot"),
        UIImage(named: "ify"),
        UIImage(named: "usd")
    ]    
    private init () {}
    
}

enum Link: String {
    case cryptoUrl = "https://api.coingecko.com/api/v3/exchange_rates"
}
