//
//  EventTrackingInstruction.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

extension InstructionViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "Instruction_impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingButtonNext(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_StepScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
    
    func trackingButtonDone(eventName: String) {
        var param: [String: Any] = [:]
        param["click"] = "Button_Goto_HomeScreen_click"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
}

extension StepViewController {
    func trackingShowScreenImpression(eventName: String) {
        var param: [String: Any] = [:]
        param["impression"] = "Step_Impression"
        addFirebaseEventLog(eventName: eventName, param: param)
    }
}
