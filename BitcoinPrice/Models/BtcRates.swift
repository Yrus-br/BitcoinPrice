//
//  BtcPrice.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

import Foundation
import Alamofire

struct BtcRates {
    let rates: Currency
}

struct Currency {
    let btc: Rates
    let eth: Rates
}

struct Rates {
    let name: String
    let unit: String
    let value: Double
    let type: TypeOfCurrency
}

enum TypeOfCurrency: String {
    case commodity = "commodity"
    case crypto = "crypto"
    case fiat = "fiat"
}

enum Link: String {
    case cryptoUrl = "https://api.coingecko.com/api/v3/exchange_rates"
}
