//
//  ExtendedIngredients.swift
//  Spoon Master
//
//  Created by Nam Ngây on 05/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct ExtendedIngredient: Mappable {
    
    var unit = ""
    var extenId = 0
    var image = ""
    var name = ""
    var amount = 0
    var originalString = ""
    var imageUrl: String {
        URLs.ingredientImage + image
    }
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        extenId <- map["id"]
        unit <- map["unit"]
        image <- map["image"]
        name <- map["name"]
        amount <- map["amount"]
        originalString <- map["originalString"]
    }
}
