//
//  DetailsViewController.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 30.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var nameOfCurrency: UILabel!
    @IBOutlet var symbolOfCurrency: UILabel!
    @IBOutlet var rankOfCurrency: UILabel!
    @IBOutlet var currentPrice: UILabel!
    
    var information: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        title = information?.name
        
    }
    
    private func configure() {
        nameOfCurrency.text = information?.name
        symbolOfCurrency.text = information?.symbol
        rankOfCurrency.text = information?.rank
        currentPrice.text = information?.priceUsd
    }
    
    
}
