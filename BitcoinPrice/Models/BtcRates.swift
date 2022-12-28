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

//enum Info: String, Decodable {
//    case id,
//    case rank,
//    case symbol,
//    case name,
//    case supply,
//    case maxSupply,
//    case marketCapUsd,
//    case volumeUsd24Hr,
//    case priceUsd,
//    case changePercent24Hr,
//    case vwap24Hr,
//    case explorer
//
//}
/*{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"19245556.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"319459807934.2221828691107352","volumeUsd24Hr":"5643502638.9417971953957937","priceUsd":"16599.1467294695036542","changePercent24Hr":"-0.3261389041799068","vwap24Hr":"16654.0971741319270375","explorer":"https://blockchain.info/"} */
