//
//  CryptoCell.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 06.11.2022.
//

import UIKit

class CryptoCell: UICollectionViewCell {
    @IBOutlet var CryptoLabel: UILabel!
    var cryptoCurrency: [Rate]!
    
//    func configure (with name: BtcRates?) {
//        CryptoLabel.text = "\(BtcRates.self)"
//        NetworkManager.shared.fetch([bct].self, from: Link.cryptoUrl.rawValue) { [weak self] result in
//            switch result {
//            case .success(let data):
//                self?.cryptoCurrency = data
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}


