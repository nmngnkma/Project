//
//  SearchRecipes.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/15/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchResponse: Mappable {
    
    var results: [Results] = []
    var number = 0
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
        number <- map["number"]
    }
}
