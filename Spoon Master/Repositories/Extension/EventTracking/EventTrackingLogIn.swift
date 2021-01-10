//
//  EventTrackingLogIn.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

extension LogInViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "Login_impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingNextClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_HomeScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingGoToSignUpClick(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_SignupScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
}
