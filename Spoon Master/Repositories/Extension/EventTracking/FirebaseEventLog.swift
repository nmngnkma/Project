//
//  FirebaseEventLog.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation
import FirebaseAnalytics

public func addFirebaseEventLog(eventName: String, param: [String: Any]) {
    let userProfile = Session.shared.userProfile
    var param = param
    param["user_email"] = userProfile.userEmail
    Analytics.logEvent(eventName, parameters: param)
}
