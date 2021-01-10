//
//  ErrorResponse.swift
//  Spoon Master
//
//  Created by Nam Ngây on 14/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct ErrorResponse: Mappable {
    
    var name: String = ""
    var message: String = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        message <- map["message"]
    }
}
