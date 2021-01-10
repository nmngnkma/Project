//
//  URLs.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

struct URLs {
    private static var baseUrl = "https://api.spoonacular.com"
    
    static let randomRecipes = baseUrl + "/recipes/random"
    
    static let product = baseUrl + "/food/products/search"
    
    static let searchRecipes = baseUrl + "/recipes/search"
    
    static let ingredientImage = "https://spoonacular.com/cdn/ingredients_100x100/"
    
    static let equipmentImage = "https://spoonacular.com/cdn/equipment_100x100/"
    
    static let productDetail = baseUrl + "/food/products/%d"
    
    static let recipeInfo = baseUrl + "/recipes/%d/information"
    
    static let searchRecipe = baseUrl + "/recipes/complexSearch"
}
