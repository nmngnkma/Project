//
//  Session.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

class Session {
    static var shared = Session()
    
    var userProfile = User()
}

final class User {
    var userEmail = ""
}
