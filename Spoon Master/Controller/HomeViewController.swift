//
//  HomeViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import ObjectMapper
import Then
import Firebase
import FirebaseAuth

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let repositories = Repositories(api: .share)
    private var popularFoods: [DataCell] = []
    private var popularRecipes: [DataCell] = []
    private var popularProducts: [DataCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UINib(nibName: Constant.Identifier.homeTBVCIdentifier, bundle: nil),
                        forCellReuseIdentifier: Constant.Identifier.homeTBVCIdentifier)
            $0.register(UINib(nibName: Constant.Identifier.homeHeaderView, bundle: nil),
                        forHeaderFooterViewReuseIdentifier: Constant.Identifier.homeHeaderView)
        }
        configHomeData()
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Configdata & Fetch
    private func configHomeData() {
        repositories.takeRandomRecipesData(number: 20) { [weak self] (results) in
            DispatchQueue.main.async {
                self?.fetchRecipesData(results)
            }
        }
        repositories.takeProductData(query: "protein", number: 10) { [weak self] (results) in
            DispatchQueue.main.async {
                self?.fetchProductData(results)
            }
        }
    }
    
    private func fetchRecipesData( _ results: BaseResult<RandomRecipes>) {
        switch results {
        case .success(let data):
            guard let recipeData = data?.recipes.map({
                DataCell.recipesCell($0)
            }) else { return }
            for (index, value) in recipeData.enumerated() {
                if index % 2 == 0 {
                    popularFoods.append(value)
                } else {
                    popularRecipes.append(value)
                }
            }
            tableView.reloadData()
        case .failure:
            createPopup()
        }
    }
    
    private func fetchProductData( _ results: BaseResult<Product>) {
        switch results {
        case .success(let data):
            let productData = data?.products.map {
                DataCell.productsCell($0)
            }
            popularProducts += productData ?? []
            tableView.reloadData()
        case .failure:
            createPopup()
        }
    }
    
    func createPopup() {
        let alert = UIAlertController(title: "Error", message: "Cannot connect to network", preferredStyle: .alert)
        let OKaction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { _ in
            self.configHomeData()
        }
        alert.addAction(OKaction)
        alert.addAction(tryAgainAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func showPopup(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "PopupMutiple", bundle: nil)
        if let popup = storyboard.instantiateViewController(withIdentifier: "PopupFuncViewController") as? PopupFuncViewController {
            popup.delegate = self
            popup.modalPresentationStyle = .overFullScreen
            popup.modalTransitionStyle = .crossDissolve
            present(popup, animated: true, completion: nil)
        }
    }
    
    @IBAction func searchScreen(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: Constant.Storyboard.searchResult, bundle: nil)
        if let resultVC = storyboard.instantiateViewController(
            withIdentifier: Constant.Identifier.searchViewController) as?
            SearchViewController {
            navigationController?.pushViewController(resultVC, animated: true)
        }
    }
}

// MARK: - UITableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Height.heightForRow
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.Number.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.Identifier.homeTBVCIdentifier,
            for: indexPath) as? HomeTableViewCell
            else { return UITableViewCell() }
        cell.delegate = self
        
        switch indexPath.section {
        case 0:
            cell.configData(popularFoods)
        case 1:
            cell.configData(popularRecipes)
        default:
            cell.configData(popularProducts)
        }
        return cell
    }
    
    // MARK: - Custom TableView Cell
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constant.Number.numberOfSection
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Height.heightOfHeaderInSection
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.tableView.dequeueReusableHeaderFooterView(
            withIdentifier: Constant.Identifier.homeHeaderView) as?
            HomeHeaderView else {
                return UIView()
        }
        if traitCollection.userInterfaceStyle == .light {
            header.setupToggle(false)
        } else {
            header.setupToggle(true)
        }
        switch section {
        case 0:
            header.setupName(sectionTitle: Constant.popularFoods)
        case 1:
            header.setupName(sectionTitle: Constant.popularRecipes)
        default:
            header.setupName(sectionTitle: Constant.popularProducts)
        }
        return header
    }
}

// MARK: - HomeDelegate
extension HomeViewController: HomeDelegate {
    func navigateToDetailScreen(_ data: DataCell) {
        switch data {
        case .recipesCell(let value):
            let storyboard = UIStoryboard(name: Constant.Storyboard.detail, bundle: nil)
            if let detailVC = storyboard.instantiateViewController(
                withIdentifier: Constant.Identifier.detailViewController) as?
                DetailViewController {
                detailVC.takeRecipeID(value.randomId)
                navigationController?.pushViewController(detailVC, animated: true)
            }
            
        case .productsCell(let value):
            let storyboard = UIStoryboard(name: Constant.Storyboard.product, bundle: nil)
            if let productVC = storyboard.instantiateViewController(
                withIdentifier: Constant.Identifier.productViewController) as?
                ProductViewController {
                productVC.getData(value)
                navigationController?.pushViewController(productVC, animated: true)
            }
        }
    }
}

extension HomeViewController: PopupDelegate {
    func favouriteVC() {
        let storyboard = UIStoryboard(name: Constant.Storyboard.favorite, bundle: nil)
        if let favVC = storyboard.instantiateViewController(withIdentifier: Constant.Identifier.favoriteViewController) as? FavoriteViewController {
            navigationController?.pushViewController(favVC, animated: true)
        }
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let storyboard = UIStoryboard(name: "LogInView", bundle: nil)
            if let logInView = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController {
                navigationController?.pushViewController(logInView, animated: true)
            }
        } catch let signOutError as NSError {
            print(signOutError)
            popupErrorSignout()
        }
    }
    
    func popupErrorSignout() {
        let alert = UIAlertController(title: "Error", message: "Logout has error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
