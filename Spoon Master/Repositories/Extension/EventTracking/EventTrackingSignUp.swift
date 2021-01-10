//
//  EventTrackingSignUp.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

extension SignupViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "Signup_impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingButtonNextClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_HomeScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
}
