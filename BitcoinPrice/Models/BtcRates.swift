//
//  BtcPrice.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

// MARK: Need to add init for models to create array of currency's for collection view 

// MARK: - Currency
struct Currency: Decodable {
    let data: [Info]
    let timestamp: Int
}

struct Info: Decodable {
    let id: String
    let rank: String?
    let symbol: String?
    let name: String?
    let supply: String?
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?

}
