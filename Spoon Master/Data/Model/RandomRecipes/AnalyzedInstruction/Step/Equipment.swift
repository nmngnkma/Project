//
//  Equipment.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/5/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct Equipment: Mappable {
    
    var equipmentId = 0
    var name = ""
    var localizedName = ""
    var image = ""
    var equipmentImage: String {
        URLs.equipmentImage + image
    }
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        equipmentId <- map["id"]
        name <- map["name"]
        localizedName <- map["localizedName"]
        image <- map["image"]
    }
}
