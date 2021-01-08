//
//  DetailViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Then
import Kingfisher
import CoreData

final class DetailViewController: UIViewController, UICollectionViewDelegate {
    
    private var data: Recipe? {
        didSet {
            guard let data = data else { return }
            setDetail(data)
            loadContext(data.title)
        }
    }
    private let context = (UIApplication.shared.delegate as? AppDelegate)?
        .persistentContainer.viewContext
    private var repositories = Repositories(api: .share)
    private var checked: Bool?
    
    @IBOutlet private weak var likeButton: UIBarButtonItem!
    @IBOutlet private weak var avatarFoodImage: UIImageView!
    @IBOutlet private weak var summaryTextView: UITextView!
    @IBOutlet private weak var nameFoodLabel: UILabel!
    @IBOutlet private weak var moneyLabel: UILabel!
    @IBOutlet private weak var slideOfPersonLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var goToIngredientButton: UIButton!
    @IBOutlet private weak var goToInstructionButton: UIButton!
    @IBOutlet private weak var vegetarianLabel: UILabel!
    @IBOutlet private weak var veganLabel: UILabel!
    @IBOutlet private weak var glutenLabel: UILabel!
    @IBOutlet private weak var dairyLabel: UILabel!
    @IBOutlet private weak var healthyLabel: UILabel!
    @IBOutlet private weak var cheapLabel: UILabel!
    @IBOutlet private weak var popularLabel: UILabel!
    @IBOutlet private weak var sustainableLabel: UILabel!
    @IBOutlet private weak var smartPointLabel: UILabel!
    @IBOutlet private weak var gapsLabel: UILabel!
    @IBOutlet private weak var lowFodmapLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCell()
    }
    
    func takeRecipeID( _ recipeId: Int) {
        configData(recipeId)
    }
    
    func setDetail(_ data: Recipe) {
        let url = URL(string: "\(data.image)")
        nameFoodLabel.text = data.title
        avatarFoodImage.kf.setImage(with: url)
        summaryTextView.text = data.summary.htmlToString
        moneyLabel.text = "\(data.pricePerServing)$"
        timeLabel.text = "\(data.readyInMinutes)m"
        slideOfPersonLabel.text = "\(data.servings)"
        scoreLabel.text = "\(data.spoonacularScore)"
        vegetarianLabel.text = "\(data.vegetarian)"
        veganLabel.text = "\(data.vegan)"
        glutenLabel.text = "\(data.glutenFree)"
        dairyLabel.text = "\(data.dairyFree)"
        healthyLabel.text = "\(data.veryHealthy)"
        cheapLabel.text = " \(data.cheap)"
        popularLabel.text = "\(data.veryPopular)"
        sustainableLabel.text = "\(data.sustainable)"
        smartPointLabel.text = "\(data.weightWatcherSmartPoints)"
        gapsLabel.text = "\(data.gaps)"
        lowFodmapLabel.text = "\(data.lowFodmap)"
        likesLabel.text = "\(data.aggregateLikes)"
    }
    
    func configCell() {
        summaryTextView.isEditable = false
        moneyLabel.wrapContent()
        nameFoodLabel.wrapContent()
        goToIngredientButton.makeRoundCorner()
        goToInstructionButton.makeRoundCorner()
    }
    
    // MARK: - Fetch and config data
    func configData(_ recipeId: Int) {
        repositories.getRecipeInfo(recipeId: recipeId) { [weak self] (results) in
            self?.fetchData(results)
        }
    }
    
    func fetchData( _ result: BaseResult<Recipe>) {
        switch result {
        case .success(let value):
            if let newValue = value {
                data = newValue
            }
        case .failure(let error):
            print("Error at DetailVC: \(error)")
        }
    }
    
    @IBAction func goToInstruction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Constant.Storyboard.instruction, bundle: nil)
        guard let instructionVC = storyboard.instantiateViewController(withIdentifier: Constant.Identifier.instructionViewController) as?
            InstructionViewController,
            let newData = data else { return }
        
        instructionVC.takeInstructionData(newData.analyzedInstructions)
        navigationController?.pushViewController(instructionVC, animated: true)
        
    }
    
    @IBAction private func goToIngredient(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Constant.Storyboard.ingredient, bundle: nil)
        guard let ingredientVC = storyboard.instantiateViewController(
            withIdentifier: Constant.Identifier.ingredientViewController) as?
            IngredientViewController,
            let newData = data else { return }
        
        ingredientVC.takeIngredientData(newData)
        navigationController?.pushViewController(ingredientVC, animated: true)
        
    }
    
    @IBAction private func addToFavorite(_ sender: UIBarButtonItem) {
        loadContext(data?.title ?? "")
        guard let check = checked, let recipe = data else { return }
        if check {
            saveContext(recipe)
            sender.image = UIImage(systemName: "heart.fill")
        } else {
            let alert = UIAlertController(title: "Are you sure ?",
                                          message: "This recipe will be not favorite",
                                          preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                self?.deleteContext(recipe.title)
                sender.image = UIImage(systemName: "heart")
            }
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    // MARK: - Working with context
    func saveContext(_ recipe: Recipe) {
        guard let unwrapContext = context else { return }
        let favRecipe = FavoriteRecipe(context: unwrapContext)
        favRecipe.do {
            $0.name = recipe.title
            $0.image = recipe.image
            $0.recipeId = Int64(recipe.randomId)
        }
        
        do {
            try context?.save()
        } catch {
            print("Saving has error")
        }
    }
    
    func deleteContext(_ title: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constant.CoreData.favoriteRecipe)
        let predicate = NSPredicate(format: "name == %@", title)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            guard let items = try context?.fetch(request) as? [NSManagedObject] else { return }
            if items.isEmpty == false {
                context?.delete(items[0])
            }
            
            try context?.save()
        } catch {
            print("error")
        }
    }
    
    func loadContext(_ title: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constant.CoreData.favoriteRecipe)
        let predicate = NSPredicate(format: "name == %@", title)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            guard let count = try context?.count(for: request) else { return }
            switch count {
            case 0:
                checked = true
                likeButton.image = UIImage(systemName: "heart")
            default:
                checked = false
                likeButton.image = UIImage(systemName: "heart.fill")
                
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
