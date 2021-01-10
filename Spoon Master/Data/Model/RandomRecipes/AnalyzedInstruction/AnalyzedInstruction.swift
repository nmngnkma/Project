//
//  AnalyzedInstructions.swift
//  Spoon Master
//
//  Created by Nam Ngây on 05/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct AnalyzedInstruction: Mappable {
    var name = ""
    var steps: [Step] = []
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        steps <- map["steps"]
    }
}
