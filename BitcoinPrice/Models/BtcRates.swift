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
    
    init(rates: Currencys) {
        self.rates = rates
    }
    
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
    
    func getCurrency() -> [Price] {
        var arrayOfCurrencys: [Price] = []
        
        arrayOfCurrencys.append(btc)
        
        return []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.btc = try container.decode(Price.self, forKey: .btc)
        self.eth = try container.decode(Price.self, forKey: .eth)
        self.ltc = try container.decode(Price.self, forKey: .ltc)
        self.bch = try container.decode(Price.self, forKey: .bch)
        self.bnb = try container.decode(Price.self, forKey: .bnb)
        self.eos = try container.decode(Price.self, forKey: .eos)
        self.xrp = try container.decode(Price.self, forKey: .xrp)
        self.xlm = try container.decode(Price.self, forKey: .xlm)
        self.link = try container.decode(Price.self, forKey: .link)
        self.dot = try container.decode(Price.self, forKey: .dot)
        self.yfi = try container.decode(Price.self, forKey: .yfi)
        self.usd = try container.decode(Price.self, forKey: .usd)
    }
}

struct Price: Codable {
    let name: String
    let unit: String
    let value: Double
    let type: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.unit = try container.decode(String.self, forKey: .unit)
        self.value = try container.decode(Double.self, forKey: .value)
        self.type = try container.decode(String.self, forKey: .type)
    }
}
