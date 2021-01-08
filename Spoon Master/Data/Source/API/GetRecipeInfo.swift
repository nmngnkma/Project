//
//  GetRecipeInfo.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/18/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

class GetRecipeInfo: BaseRequest {
    
    required init(recipeId: Int) {
        let url = String(format: URLs.recipeInfo, recipeId)
        let body: [String: Any] = [
            "apiKey": ApiKey.apiKey
        ]
        super.init(url: url, requestType: .get, body: body)
    }
}
