//
//  BtcPrice.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

// MARK: Need to add init for models to create array of currency's for collection view 

import Foundation
import UIKit

struct Rates: Codable {
    let rates: Currencys
}

struct Currencys: Codable {
    let btc: Price
    let eth: Price
    let ltc: Price
    let bch: Price
    let bnb: Price
    let eos: Price
    let xrp: Price
    let xlm: Price
    let link: Price
    let dot: Price
    let yfi: Price
    let usd: Price
}

struct Price: Codable {
    let name: String
    let unit: String
    let value: Double
    let type: String
}
