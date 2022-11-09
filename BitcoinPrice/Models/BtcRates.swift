//
//  BtcPrice.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

struct BtcRates: Codable {
    let rates: [String: Rate]
}

struct Rate: Codable {
    let name: String
let unit: String
    let value: Double
    let type: String
}
