//
//  BtcPrice.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

import Foundation
import Alamofire

struct BtcRates {
    let rates: [String: Rates]
    
    init(rates: [String : Rates]) {
        self.rates = rates
    }
    
//    static func getCurrencyInfo(from value: Any) -> [BtcRates] {
//        guard let rate = value as? [String: Rates] else { return [] }
//        guard let rates = rate["rates"] as? [[String: Any]] else { return [] }
//        return rates.map { BtcRates(rates: $0)}
//    }
}
struct Rates {
    let name: String
    let unit: String
    let value: Double
    let type: TypeEnum
}

struct TypeEnum {
    let crypto: String
    let commodity: String
    let fiat: String
}

enum Link: String {
    case cryptoUrl = "https://api.coingecko.com/api/v3/exchange_rates"
}
