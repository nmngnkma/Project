//
//  Item.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/17/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct Item: Mappable {
    var itemId = 0
    var title = ""
    var image = ""
    var imageType = ""
    
    init?(map: Map) {
          mapping(map: map)
      }
      
      mutating func mapping(map: Map) {
        itemId <- map["id"]
        title <- map["title"]
        image <- map["image"]
        imageType <- map["imageType"]
      }
}
