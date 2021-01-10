//
//  EventTrackingFavorite.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

extension FavoriteViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "Favorite_impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingCountOfRecipe(eventName: String, param: [String: Any]) {
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingChooseRecipe(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_Recipe_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingDeleteRecipe(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Delete_Recipe_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
}
