//
//  EventTrackingHomeScreen.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

extension HomeViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "HomeScreen_impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingSearchButtonClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_SearchScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingFavouriteButtonClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_FavoriteScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingLogOutButtonClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_LogoutScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingChooseRecipeClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_Detail(Recipe)_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingChooseProductClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_Detail(Product)_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
}
