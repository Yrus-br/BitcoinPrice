//
//  BtcPrice.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

import Foundation
import UIKit

struct BtcRates {
    let rates: currencys
}

struct currencys {
    let btc: Rates
}

struct Rates: Decodable {
    let name: String
    let unit: String
    let value: Double
    let type: String
}
////    enum CodingKeys: String, CodingKey {
////        case name = "name"
////        case unit = "unit"
////        case value = "value"
////        case type = "type"
////    }
//}
//
//enum TypeOfCurrency: String {
//    case commodity = "commodity"
//    case crypto = "crypto"
//    case fiat = "fiat"
//}

enum Link: String {
    case cryptoUrl = "https://api.coingecko.com/api/v3/exchange_rates"
}
