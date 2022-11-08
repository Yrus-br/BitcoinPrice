//
//  DataManager.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 08.11.2022.
//

class DataManager {
    static let shared = DataManager()
    private init () {}
    
    let cryptoImage = [
        "bitcoin",
        "eth",
        "litecoin",
        "btccash",
        "bnb",
        "eos",
        "xrp",
        "xlm.icon",
        "chainlink",
        "dot",
        "ify",
        "usd"
    ]
    var btcPrice: String = ""
     var ethPrice: String = ""
     var ltcPrice: String = ""
     var bchPrice: String = ""
     var bnbPrice: String = ""
     var eosPrice: String = ""
     var xrpPrice: String = ""
     var xlmPrice: String = ""
     var linkPrice: String = ""
     var dotPrice: String = ""
     var yfiPrice: String = ""
     var usdPrice: String = ""
}

enum Cryptos: String, CaseIterable {
    case btc = "Bitcoin"
    case eth = "Etherium"
    case ltc = "Litecoin"
    case bch = "Bitcoin Cash"
    case bnb = "Binance Coin"
    case eos = "Eos"
    case xrp = "XRP"
    case xlm = "XLM"
    case link = "ChainLink"
    case dot = "Polkadot"
    case yfi = "YFI"
    case usd = "USD"
}
