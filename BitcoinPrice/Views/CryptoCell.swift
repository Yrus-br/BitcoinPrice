//
//  CryptoCell.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 06.11.2022.
//

import UIKit

class CryptoCell: UICollectionViewCell {
    @IBOutlet var cryptoImage: UIImageView!
    @IBOutlet var CryptoLabel: UILabel!
    
    func configure(with currency: Info?) {
        CryptoLabel.text = currency?.name
        cryptoImage.image = DataManager.shared.cryptoImage.first as? UIImage
    }
}
