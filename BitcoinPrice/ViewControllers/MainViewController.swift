//
//  MainViewController.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 05.11.2022.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    private var lol: [Currency] = []
    
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
        cell.cryptoImage.image = UIImage(named: cryptoImages[indexPath.item])
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 3
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let col = Cryptos.allCases
        _ = col[indexPath.item]
        showCurrentPrice(title: "\(lol)", message: "ki")
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.6
        
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
                self?.setPrices(currency: data.rates)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setPrices(currency: Currency) {
        DispatchQueue.main.async {
            DataManager.shared.btcPrice = self.formatPrice(currency.btc)
            DataManager.shared.ethPrice = self.formatPrice(currency.eth)
            DataManager.shared.ltcPrice = self.formatPrice(currency.ltc)
            DataManager.shared.bchPrice = self.formatPrice(currency.bch)
            DataManager.shared.bnbPrice = self.formatPrice(currency.bnb)
            DataManager.shared.eosPrice = self.formatPrice(currency.eos)
            DataManager.shared.xrpPrice = self.formatPrice(currency.xrp)
            DataManager.shared.xlmPrice = self.formatPrice(currency.xlm)
            DataManager.shared.linkPrice = self.formatPrice(currency.link)
            DataManager.shared.dotPrice = self.formatPrice(currency.dot)
            DataManager.shared.yfiPrice = self.formatPrice(currency.yfi)
            DataManager.shared.usdPrice = self.formatPrice(currency.usd)
        }
    }
    
    func formatPrice(_ price: Price) -> String {
        String(format: "%.4f %@", price.value, price.unit)
    }
}
