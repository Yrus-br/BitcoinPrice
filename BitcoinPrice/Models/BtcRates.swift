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
    
    init(value: [String:Any]) {
        rates = value["rates"] as? [String: Rates] ?? [:]
    }

    
    static func getCurrency(from value: Any) -> [BtcRates] {
        guard let currency = value as? [String: Rates] else { return [] }
        guard let coin = currency as? [[String: Rates]] else { return [] }
        return coin.map { BtcRates(value: $0)}
    }
}

struct Rates {
    let name: String
    let unit: String
    let value: Double
    let type: TypeOfCuttency
    
    init(item: [String: Any]) {
        name = item["name"] as? String ?? ""
        unit = item["unit"] as? String ?? ""
        value = item["value"] as? Double ?? 0
        
        let types = item["type"] as? [String: String] ?? [:]
        type = TypeOfCuttency(value: types)
    }
}

struct TypeOfCuttency{
    var commodity = "commodity"
    var crypto = "crypto"
    var fiat = "fiat"
    
    init(value: [String: String]) {
        commodity = value["name"] ?? ""
        crypto = value["crypto"] ?? ""
        fiat = value["fiat"] ?? ""
    }
}

enum Link: String {
    case cryptoUrl = "https://api.coingecko.com/api/v3/exchange_rates"
}
