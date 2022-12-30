//
//  MainViewController.swift
//  BitcoinPrice
//
//  Created by Jorgen Shiller on 05.11.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

final class MainViewController: UICollectionViewController, UISearchResultsUpdating {
    
    private var allCurrencys: Currency?
    private var currencyArray: [Info] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        getData()
        setItemSize()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        isFiltering ? currencyArray.count : allCurrencys?.data.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crypto", for: indexPath)
        guard let cell = cell as? CryptoCell else { return UICollectionViewCell() }
        
        let currency = isFiltering ? currencyArray[indexPath.row] : allCurrencys?.data[indexPath.row]
        cell.configure(with: currency)
        cell.CryptoLabel.text = currency?.name
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 3
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.6
        print(currencyArray.count)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1
        print()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    private func getData() {
        NetworkManager.shared.fetchData(Currency.self, from: Link.cryptoUrl.rawValue) { [weak self] result in
            switch result {
            case .success(let value):
               self?.allCurrencys = value
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        currencyArray = allCurrencys?.data.filter { character in
            character.id.lowercased().contains(searchText.lowercased())
        } ?? []
        
        collectionView.reloadData()
    }
}
