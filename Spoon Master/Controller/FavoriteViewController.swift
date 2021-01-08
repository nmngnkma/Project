//
//  FavoriteViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import CoreData

final class FavoriteViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var blankImage: UIImageView!
    @IBOutlet private weak var blankTitle: UILabel!
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?
        .persistentContainer.viewContext
    private var favRecipe = [FavoriteRecipe]()
    private var repositories = Repositories(api: .share)
    private var info: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        fetchContext()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    func configView() {        
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.tableFooterView = UIView()
            $0.register(UINib(nibName: Constant.Identifier.favoriteTableViewCell, bundle: nil),
                        forCellReuseIdentifier: Constant.Identifier.favoriteTableViewCell)
        }
    }
    
    func fetchContext() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constant.CoreData.favoriteRecipe)
        
        do {
            guard let newData = try context?.fetch(fetchRequest) as? [FavoriteRecipe] else { return }
            favRecipe = newData
            
            if favRecipe.isEmpty {
                tableView.isHidden = true
                blankImage.isHidden = false
                blankTitle.isHidden = false
            } else {
                tableView.isHidden = false
                blankImage.isHidden = true
                blankTitle.isHidden = true
            }
        } catch {
            print("Fetching context has error ")
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewCell Delegate DataSource
extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: Constant.Storyboard.detail, bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(
            withIdentifier: Constant.Identifier.detailViewController) as?
            DetailViewController else { return }
        
        detailVC.takeRecipeID(Int(favRecipe[indexPath.row].recipeId))
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Height.heightForFavoriteRow
    }
    
}

// MARK: - UITableViewCell DataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.Identifier.favoriteTableViewCell, for: indexPath) as?
            FavoriteTableViewCell else {
                return UITableViewCell()
        }
        cell.setupView(favRecipe[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = favRecipe[indexPath.row]
            context?.delete(commit)
            favRecipe.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            do {
                try context?.save()
            } catch {
                print("Saving error")
            }
        }
    }
}
