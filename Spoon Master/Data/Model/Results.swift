//
//  Results.swift
//  Spoon Master
//
//  Created by Nam Ngây on 15/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct Results: Mappable {
    var recipesId = 0
    var readyInMinute = 0
    var title = ""
    var image = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        recipesId <- map["id"]
        readyInMinute <- map["readyInMinutes"]
        title <- map["title"]
        image <- map["image"]
    }
}
