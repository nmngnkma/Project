//
//  Nutrition.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/5/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct Nutrition: Mappable {
    
    var nutrients: [Nutrient] = []
    var caloricBreakdowns: [CaloricBreakdown] = []
    var calories = 0
    var protein = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        nutrients <- map["nutrients"]
        caloricBreakdowns <- map["caloricBreakdown"]
        calories <- map["calories"]
        protein <- map["protein"]
    }
}
