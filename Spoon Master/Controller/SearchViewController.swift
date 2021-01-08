//
//  SegmentedViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 1/6/21.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Then

final class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchbar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet private weak var blankSearchImage: UIImageView!
    @IBOutlet private weak var blankTitle: UILabel!
    
    private var response: SearchResponse? {
        didSet {
            results = response?.results ?? []
            activityView.stopAnimating()
            activityView.isHidden = true
            tableView.reloadData()
        }
    }
    private var product: Product? {
        didSet {
            items = product?.products ?? []
            activityView.stopAnimating()
            activityView.isHidden = true
            tableView.reloadData()
        }
    }
    private var repositories = Repositories(api: .share)
    private var searchText = ""
    private var results = [Results]()
    private var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        segmentControl.selectedSegmentIndex = 0
    }
    
    func configView() {
        searchbar.delegate = self
        activityView.isHidden = true
        tableView.do {
            $0.isHidden = true
            $0.delegate = self
            $0.dataSource = self
            $0.register(UINib(nibName: Constant.Identifier.searchResultTableViewCell, bundle: nil),
                        forCellReuseIdentifier: Constant.Identifier.searchResultTableViewCell)
        }
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    func configData() {
        repositories.searchRecipe(query: searchText, number: 100) { [weak self] (results) in
            self?.fetchRecipe(results)
        }
        repositories.takeProductData(query: searchText, number: 100) { [weak self] (results) in
            self?.fetchProduct(results)
        }
    }
    
    func fetchRecipe( _ data: BaseResult<SearchResponse>) {
        DispatchQueue.main.async {
            switch data {
            case .success(let value):
                self.response = value
            case .failure(let error):
                print("Error \(String(describing: error))")
            }
        }
    }
    func fetchProduct( _ data: BaseResult<Product>) {
        DispatchQueue.main.async {
            switch data {
            case .success(let value):
                self.product = value
            case .failure(let error):
                print("Error \(String(describing: error))")
            }
            self.tableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchbar.endEditing(true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text?.isEmpty ?? true {
            searchBar.placeholder = "Type some recipe"
            tableView.isHidden = true
            blankSearchImage.isHidden = false
            blankTitle.isHidden = false
            return true
        } else {
            tableView.isHidden = false
            blankSearchImage.isHidden = true
            blankTitle.isHidden = true
            return false
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? ""
        configData()
        tableView.reloadData()
        activityView.isHidden = false
        activityView.startAnimating()
        searchbar.endEditing(true)
        tableView.keyboardDismissMode = .onDrag
    }
}

// MARK: - UITableViewDelegate DataSource
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            repositories.getRecipeInfo(recipeId: results[indexPath.row].recipesId) { [weak self] (result) in
                switch result {
                case .success(let value):
                    let storyboard = UIStoryboard(name: Constant.Storyboard.detail, bundle: nil)
                    guard let detailVC = storyboard.instantiateViewController(withIdentifier: Constant.Identifier.detailViewController) as? DetailViewController,
                        let newData = value else { return }
                    
                    detailVC.takeRecipeID(newData.randomId)
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                    
                case .failure(let error):
                    print(error ?? "")
                }
            }
        default:
            repositories.getProductInfo(productId: items[indexPath.row].itemId) { [weak self] (result) in
                switch result {
                case .success(let value):
                    let storyboard = UIStoryboard(name: Constant.Storyboard.product, bundle: nil)
                    guard let productVC = storyboard.instantiateViewController(withIdentifier: Constant.Identifier.productViewController) as? ProductViewController,
                        let newData = value else { return }
                    
                    productVC.getData(newData)
                    self?.navigationController?.pushViewController(productVC, animated: true)
                case .failure(let error):
                    print(error ?? "")
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate DataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return results.count
        default:
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            Constant.Identifier.searchResultTableViewCell, for: indexPath) as?
            SearchResultTableViewCell else {
                return UITableViewCell()
        }
        switch self.segmentControl.selectedSegmentIndex {
        case 0:
            cell.setupView(results[indexPath.row])
        default:
            cell.setUpView(items[indexPath.row])
        }
        return cell
    }
}
