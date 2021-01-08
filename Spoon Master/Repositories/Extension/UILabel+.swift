//
//  UILabel+.swift
//  Spoon Master
//
//  Created by Nam Ngây on 1/1/21.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func wrapContent() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.2
    }
}
