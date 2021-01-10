//
//  Nutrient.swift
//  Spoon Master
//
//  Created by Nam Ngây on 17/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct Nutrient: Mappable {
    
    var title = ""
    var amount = 0
    var unit = ""
    var percentOfDailyNeeds = 0.0
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        amount <- map["amount"]
        unit <- map["unit"]
        percentOfDailyNeeds <- map["percentOfDailyNeeds"]
    }
}
