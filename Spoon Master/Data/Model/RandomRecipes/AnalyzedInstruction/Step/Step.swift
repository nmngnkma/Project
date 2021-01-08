//
//  File.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/9/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct Step: Mappable {
    
    var number = 0
    var step = ""
    var ingredients: [Ingredient] = []
    var equiments: [Equipment] = []
    var length = Length()
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        number <- map["number"]
        step <- map["step"]
        ingredients <- map["ingredients"]
        equiments <- map["equipment"]
        length <- map["length"]
    }
}
