//
//  SearchProductDetail.swift
//  Spoon Master
//
//  Created by Nam Ngây on 08/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation

class SearchProductDetail: BaseRequest {
    
    required init(productId: Int) {
        let url = String(format: URLs.productDetail, productId)
        let body: [String: Any] = [
            "apiKey": ApiKey.apiKey
        ]
        super.init(url: url, requestType: .get, body: body)
    }
}
