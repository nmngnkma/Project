//
//  RandomRecipes.swift
//  Spoon Master
//
//  Created by Nam Ngây on 05/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct RandomRecipes: Mappable {
    var recipes: [Recipe] = []
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        recipes <- map["recipes"]
    }
}

struct Recipe: Mappable {
    
    var extendedIngredients: [ExtendedIngredient] = []
    var randomId = 0
    var title = ""
    var readyInMinutes = 0
    var pricePerServing = 0.0
    var servings = 0
    var image = ""
    var summary = ""
    var instructions = ""
    var analyzedInstructions: [AnalyzedInstruction] = []
    var spoonacularScore = 0
    var vegetarian = false
    var vegan = false
    var glutenFree = false
    var dairyFree = false
    var veryHealthy = false
    var cheap = false
    var veryPopular = false
    var sustainable = false
    var weightWatcherSmartPoints = 0
    var gaps = ""
    var lowFodmap = false
    var aggregateLikes = 0
    
    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        randomId <- map["id"]
        title <- map["title"]
        readyInMinutes <- map["readyInMinutes"]
        pricePerServing <- map["pricePerServing"]
        image <- map["image"]
        servings <- map["servings"]
        summary <- map["summary"]
        instructions <- map["instructions"]
        spoonacularScore <- map["spoonacularScore"]
        extendedIngredients <- map["extendedIngredients"]
        analyzedInstructions <- map["analyzedInstructions"]
        vegetarian <- map["vegetarian"]
        vegan <- map["vegan"]
        glutenFree <- map["glutenFree"]
        dairyFree <- map["dairyFree"]
        veryHealthy <- map["veryHealthy"]
        cheap <- map["cheap"]
        veryPopular <- map["veryPopular"]
        sustainable <- map["sustainable"]
        weightWatcherSmartPoints <- map["weightWatcherSmartPoints"]
        gaps <- map["gaps"]
        lowFodmap <- map["lowFodmap"]
        aggregateLikes <- map["aggregateLikes"]
    }
}
