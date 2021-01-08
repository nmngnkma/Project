//
//  ProductDetail.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/5/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProductDetail: Mappable {
    
    var productId = 0
    var title = ""
    var price = 0
    var nutritions: [Nutrition] = []
    var servingSize = ""
    var description = ""
    var likes = 0
    var ingredients: [IngredientP] = []
    var spoonacularScore = 0
    var ingredientList = ""
    var images: [String] = []
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        productId <- map["id"]
        title <- map["title"]
        price <- map["price"]
        nutritions <- map["nutrition"]
        servingSize <- map["serving_size"]
        description <- map["description"]
        likes <- map["likes"]
        ingredients <- map["ingredients"]
        spoonacularScore <- map["spoonacular_score"]
        ingredientList <- map["ingredientList"]
        images <- map["images"]
    }
}
