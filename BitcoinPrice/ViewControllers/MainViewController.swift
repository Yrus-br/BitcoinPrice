//
//  MainViewController.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 05.11.2022.
//

import UIKit

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

final class MainViewController: UICollectionViewController {
    
    let allCryptos = Cryptos.allCases
    var cryptoCurrency: BtcRates?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setItemSize()
        fetchData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.cryptoImage.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crypto", for: indexPath)
        guard let cell = cell as? CryptoCell else { return UICollectionViewCell() }
        let cryptoImages = DataManager.shared.cryptoImage
        
        let currencyName = Cryptos.allCases
        cell.CryptoLabel.text = currencyName[indexPath.item].rawValue
        
        cell.cryptoImage.image = UIImage(named: cryptoImages[indexPath.item])
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 3
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let cryptocell = allCryptos[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.6
        
        switch cryptocell {
        case .btc:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.usd.name ?? ""):", message: "\(cryptoCurrency?.rates.usd.value ?? 0) \(cryptoCurrency?.rates.usd.unit ?? "")")
        case .eth: ()
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.eth.name ?? ""):", message: "\(cryptoCurrency?.rates.eth.value ?? 0) \(cryptoCurrency?.rates.eth.unit ?? "")")
        case .ltc:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.ltc.name ?? ""):", message: "\(cryptoCurrency?.rates.ltc.value ?? 0) \(cryptoCurrency?.rates.ltc.unit ?? "")")
        case .bch:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.bch.name ?? ""):", message: "\(cryptoCurrency?.rates.bch.value ?? 0) \(cryptoCurrency?.rates.bch.unit ?? "")")
        case .bnb:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.bnb.name ?? ""):", message: "\(cryptoCurrency?.rates.bnb.value ?? 0) \(cryptoCurrency?.rates.bnb.unit ?? "")")
        case .eos:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.eos.name ?? ""):", message: "\(cryptoCurrency?.rates.eos.value ?? 0) \(cryptoCurrency?.rates.eos.unit ?? "")")
        case .xrp:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.xrp.name ?? ""):", message: "\(cryptoCurrency?.rates.xrp.value ?? 0) \(cryptoCurrency?.rates.xrp.unit ?? "")")
        case .xlm:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.xlm.name ?? ""):", message: "\(cryptoCurrency?.rates.xlm.value ?? 0) \(cryptoCurrency?.rates.xlm.unit ?? "")")
        case .link:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.link.name ?? ""):", message: "\(cryptoCurrency?.rates.link.value ?? 0) \(cryptoCurrency?.rates.link.unit ?? "")")
        case .dot:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.dot.name ?? ""):", message: "\(cryptoCurrency?.rates.dot.value ?? 0) \(cryptoCurrency?.rates.dot.unit ?? "")")
        case .yfi:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.yfi.name ?? ""):", message: "\(cryptoCurrency?.rates.yfi.value ?? 0) \(cryptoCurrency?.rates.yfi.unit ?? "")")
        default:
            showCurrentPrice(title: "Price for 1 BTC in \(cryptoCurrency?.rates.usd.name ?? ""):", message: "\(cryptoCurrency?.rates.usd.value ?? 0) \(cryptoCurrency?.rates.usd.unit ?? "")")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1
    }
    
    // MARK: Private Methods
    
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
}

// MARK: Networking

extension MainViewController {
    private func fetchData() {
        NetworkManager.shared.fetch(BtcRates.self, from: Link.cryptoUrl.rawValue) { [weak self] result in
            switch result {
            case .success(let data):
                self?.cryptoCurrency = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
