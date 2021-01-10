//
//  UILabel+.swift
//  Spoon Master
//
//  Created by Nam Ngây on 01/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func wrapContent() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.2
    }
}
