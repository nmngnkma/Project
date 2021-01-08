//
//  Constant.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/12/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import UIKit

enum Constant {
    enum Number {
        static let numberOfRowsInSection = 1
        static let numberOfSection = 3
        static let categoryNumber = 3
        static let collectionNumber = 10
    }
    
    enum Height {
        static let heightOfHeaderInSection: CGFloat = 45
        static let heightForRow: CGFloat = 215
        static let heightForIngredientRow: CGFloat = 130
        static let heightForInstructionRow: CGFloat = 320
        static let heightForFavoriteRow: CGFloat = 90
        static let estimateHeightInstruction: CGFloat = 240
    }
    
    enum Identifier {
        static let homeTBVCIdentifier = "HomeTableViewCell"
        static let homeCLTVCIdentifier = "HomeCollectionViewCell"
        static let homeHeaderView = "HomeHeaderView"
        static let detailCLTVCIdentifier = "DetailCollectionViewCell"
        static let detailViewController = "DetailViewController"
        static let productViewController = "ProductViewController"
        static let ingredientViewController = "IngredientViewController"
        static let ingredientTableViewCell = "IngredientTableViewCell"
        static let instructionViewController = "InstructionViewController"
        static let instructionTableViewCell = "InstructionTableViewCell"
        static let instructionHeaderFooterView = "InstructionHeaderFooterView"
        static let ingredientCollectionViewCell = "IngredientCollectionViewCell"
        static let equipmentCollectionViewCell = "EquipmentCollectionViewCell"
        static let favoriteViewController = "FavoriteViewController"
        static let favoriteTableViewCell = "FavoriteTableViewCell"
        static let searchViewController = "SearchViewController"
        static let searchResultTableViewCell = "SearchResultTableViewCell"
    }
    
    enum Storyboard {
        static let detail = "Detail"
        static let product = "Product"
        static let ingredient = "Ingredient"
        static let instruction = "Instruction"
        static let favorite = "Favorite"
        static let searchResult = "SearchResult"
    }
    
    enum Serial {
        static let sectionOne = 0
        static let sectionTwo = 1
        static let sectionThree = 2
    }
    
    enum Time {
        static let timeToDismiss = 2.0
        static let timeToLoad = 1.0
    }
    
    enum CoreData {
        static let favoriteRecipe = "FavoriteRecipe"
    }
    
    static let popularFoods = "   Popular Foods"
    static let popularRecipes = "   Popular Recipes"
    static let popularProducts = "   Popular Products"
}
