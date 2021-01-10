//
//  EventTrackingSearch.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

extension SearchViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "Search_impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingChooseRecipe(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_Recipe_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingChooseProduct(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_Product_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
}
