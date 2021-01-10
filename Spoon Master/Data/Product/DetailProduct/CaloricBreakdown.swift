//
//  CaloricBreakdown.swift
//  Spoon Master
//
//  Created by Nam Ngây on 17/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct CaloricBreakdown: Mappable {
    
    var percentProtein = 0.0
    var percentFat = 0.0
    var percentCarbs = 0.0
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        percentProtein <- map["percentProtein"]
        percentFat <- map["percentFat"]
        percentCarbs <- map["percentCarbs"]
        
    }
}
