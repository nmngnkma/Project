//
//  SearchRequest.swift
//  Spoon Master
//
//  Created by Nam Ngây on 04/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

class SearchRequest: BaseRequest {
    
    required init(query: String, number: Int) {
        let body: [String: Any] = [
            "query": query,
            "number": number,
            "apiKey": ApiKey.apiKey
        ]
        super.init(url: URLs.searchRecipe, requestType: .get, body: body)
    }
}
