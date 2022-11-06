//
//  MainViewController.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 05.11.2022.
//

import UIKit

private let reuseIdentifier = "Cell"
private let cryptoUrl = "https://api.coingecko.com/api/v3/exchange_rates"
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


enum CryptoNames: String, CaseIterable {
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

let cryptoImage: [UIImage] = [
    UIImage(named: "bitcoin")!,
    UIImage(named: "eth")!,
    UIImage(named: "litecoin")!,
    UIImage(named: "btccash")!,
    UIImage(named: "bnb")!,
    UIImage(named: "eos")!,
    UIImage(named: "xrp")!,
    UIImage(named: "xlm.icon")!,
    UIImage(named: "chainlink")!,
    UIImage(named: "dot")!,
    UIImage(named: "ify")!,
    UIImage(named: "usd")!
]

final class MainViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: (collectionView.frame.size.width - 70) / 2,
                                 height: collectionView.frame.size.height / 5)
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CryptoNames.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crypto", for: indexPath)
        guard let cell = cell as? CryptoCell else { return UICollectionViewCell() }
        let currencyName = CryptoNames.allCases
        cell.cryptoImage.image = cryptoImage[indexPath.item]
        cell.CryptoLabel.text = currencyName[indexPath.item].rawValue
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 3
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currency = CryptoNames.allCases
        let cur = currency[indexPath.item]
        switch cur {
        case .btc:
            showCurrentPrice(title: "Price for 1 BTC is:", message: btcPrice)
        case .eth:
            showCurrentPrice(title: "Price for 1 BTC is:", message: ethPrice)
        case .ltc:
            showCurrentPrice(title: "Price for 1 BTC is:", message: ltcPrice)
        case .bch:
            showCurrentPrice(title: "Price for 1 BTC is:", message: bchPrice)
        case .bnb:
            showCurrentPrice(title: "Price for 1 BTC is:", message: bnbPrice)
        case .eos:
            showCurrentPrice(title: "Price for 1 BTC is:", message: eosPrice)
        case .xrp:
            showCurrentPrice(title: "Price for 1 BTC is:", message: xrpPrice)
        case .xlm:
            showCurrentPrice(title: "Price for 1 BTC is:", message: xlmPrice)
        case .link:
            showCurrentPrice(title: "Price for 1 BTC is:", message: linkPrice)
        case .dot:
            showCurrentPrice(title: "Price for 1 BTC is:", message: dotPrice)
        case .yfi:
            showCurrentPrice(title: "Price for 1 BTC is:", message: yfiPrice)
        case .usd:
            showCurrentPrice(title: "Price for 1 BTC is:", message: usdPrice)
        }
    }
}


extension MainViewController {
    
    private func fetchData() {
        guard let url = URL(string: cryptoUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            
            do {
                let decoder = try JSONDecoder().decode(Rates.self, from: data)
                self.setPrices(currency: decoder.rates)
            } catch {
                print(error)
                return
            }
            
        }.resume()
    }
    
    private func showCurrentPrice(
        title: String,
        message: String,
        textField: UITextField? = nil
    )
    {
        let message = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        message.addAction(okButton)
        present(message, animated: true)
    }
    
    func setPrices(currency: Currency) {
        DispatchQueue.main.async {
            btcPrice = self.formatPrice(currency.btc)
            ethPrice = self.formatPrice(currency.eth)
            ltcPrice = self.formatPrice(currency.ltc)
            bchPrice = self.formatPrice(currency.bch)
            bnbPrice = self.formatPrice(currency.bnb)
            eosPrice = self.formatPrice(currency.eos)
            xrpPrice = self.formatPrice(currency.xrp)
            xlmPrice = self.formatPrice(currency.xlm)
            linkPrice = self.formatPrice(currency.link)
            dotPrice = self.formatPrice(currency.dot)
            yfiPrice = self.formatPrice(currency.yfi)
            usdPrice = self.formatPrice(currency.usd)
            
        }
    }
    
    func formatPrice(_ price: Price) -> String {
        String(format: "%@ %.4f", price.unit, price.value)
    }
    
    struct Rates: Codable {
        let rates: Currency
    }
    
    struct Currency: Codable {
        let btc:  Price
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
}
