//
//  MainViewController.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 05.11.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

private let cryptoUrl = "https://api.coingecko.com/api/v3/exchange_rates"

private var btcPrice: String = ""
private var ethPrice: String = ""
private var ltcPrice: String = ""
private var bchPrice: String = ""
private var bnbPrice: String = ""
private var eosPrice: String = ""
private var xrpPrice: String = ""
private var xlmPrice: String = ""
private var linkPrice: String = ""
private var dotPrice: String = ""
private var yfiPrice: String = ""
private var usdPrice: String = ""

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
        setItemSize()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return Cryptos.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crypto", for: indexPath)
        guard let cell = cell as? CryptoCell else { return UICollectionViewCell() }
        let currencyName = Cryptos.allCases
        
        cell.cryptoImage.image = cryptoImage[indexPath.item]
        cell.CryptoLabel.text = currencyName[indexPath.item].rawValue
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 3
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let currency = Cryptos.allCases
        let selectedCurrency = currency[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.alpha = 0.6
        
        switch selectedCurrency {
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
        default:
            showCurrentPrice(title: "Price for 1 BTC is:", message: usdPrice)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1
    }
}

extension MainViewController {
    
    private func setItemSize() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(
            width: (collectionView.frame.size.width - 70) / 2,
            height: collectionView.frame.size.height / 5
        )
    }
    
    private func fetchData() {
        guard let url = URL(string: cryptoUrl) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Error")
                return
            }
            do {
                let decoder = try JSONDecoder().decode(Rates.self, from: data)
                self?.setPrices(currency: decoder.rates)
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
        let okButton = UIAlertAction(title: "OK", style: .default)
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
        String(format: "%.4f %@", price.value, price.unit)
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
