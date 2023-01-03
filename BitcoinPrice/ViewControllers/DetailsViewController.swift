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
    @IBOutlet var marketCupUSD: UILabel!
    
    var currency: Currency?
    var information: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    private func configure() {
        information = currency?.data.first
        nameOfCurrency.text = information?.name
        symbolOfCurrency.text = information?.symbol
    }
    
}
