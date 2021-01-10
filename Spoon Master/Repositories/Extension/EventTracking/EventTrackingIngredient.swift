//
//  EventTrackingIngredient.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

extension IngredientViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "Ingredient_impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingButtonNext(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_InstructionScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
}
