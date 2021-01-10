//
//  EventTrackingDetail.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

extension DetailViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "Detail_impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingFavouriteButton(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_FavouriteScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingDeleteFavorite(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Delete_Recipe_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingIngredientClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_IngredientScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingInstructionClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_InstructionScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
}
