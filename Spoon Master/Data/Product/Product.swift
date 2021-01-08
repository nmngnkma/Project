//
//  Product.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/5/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct Product: Mappable {
  
    var products: [Item] = []
    var totalProducts = 0
    
    init?(map: Map) {
          mapping(map: map)
      }
      
      mutating func mapping(map: Map) {
          products <- map["products"]
        totalProducts <- map["totalProducts"]
      }
}
