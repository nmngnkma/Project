//
//  BaseResult.swift
//  Spoon Master
//
//  Created by Nam Ngây on 16/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

enum BaseResult<T: Mappable> {
    case success(T?)
    case failure(error: BaseError?)
}
