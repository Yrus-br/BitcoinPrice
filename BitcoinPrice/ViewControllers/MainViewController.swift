//
//  MainViewController.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 05.11.2022.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    var cryptoCurrency: BtcRates?
    var nameOfCurrency: Rate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setItemSize()
        fetchData()
        fetchDataTwo()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return cryptoCurrency?.rates.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crypto", for: indexPath)
        guard let cell = cell as? CryptoCell else { return UICollectionViewCell() }
        
        cell.CryptoLabel.text = nameOfCurrency?.name
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 3
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
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
                self?.cryptoCurrency = data
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func fetchDataTwo() {
        NetworkManager.shared.fetch(Rate.self, from: Link.cryptoUrl.rawValue) { [weak self] result in
            switch result {
            case .success(let data):
                self?.nameOfCurrency = data
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
