//
//  SearchProductRequest.swift
//  Spoon Master
//
//  Created by Nam Ngây on 17/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

class SearchProductRequest: BaseRequest {
    
    required init(query: String, number: Int) {
        let body: [String: Any] = [
            "query": query,
            "number": number,
            "apiKey": ApiKey.apiKey
        ]
        super.init(url: URLs.product, requestType: .get, body: body)
    }
}
