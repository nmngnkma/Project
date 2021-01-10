//
//  SearchRequest.swift
//  Spoon Master
//
//  Created by Nam Ngây on 15/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

class SearchRecipesRequest: BaseRequest {

    required init(number: Int) {
        let body: [String: Any] = [
            "number": number,
            "apiKey": ApiKey.apiKey
        ]
        super.init(url: URLs.randomRecipes, requestType: .get, body: body)
    }
}
