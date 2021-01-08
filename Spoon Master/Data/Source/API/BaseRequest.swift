//
//  BaseRequest.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/15/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequest: NSObject {
    
    var url = ""
    var requestType = Alamofire.HTTPMethod.get
    var body: [String: Any]?
    
    var encoding: ParameterEncoding {
        switch requestType {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    init(url: String) {
        super.init()
        self.url = url
    }
    
    init(url: String, requestType: Alamofire.HTTPMethod) {
        super.init()
        self.url = url
        self.requestType = requestType
    }
    
    init(url: String, requestType: Alamofire.HTTPMethod, body: [String: Any]?) {
        super.init()
        self.url = url
        self.requestType = requestType
        self.body = body
    }
}
