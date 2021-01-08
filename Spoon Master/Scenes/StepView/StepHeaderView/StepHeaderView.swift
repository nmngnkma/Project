//
//  StepHeaderView.swift
//  Spoon Master
//
//  Created by Nam Ngây on 1/9/21.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

final class StepHeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var headerLabel: UILabel!
    
    func setupName( _ name: String) {
        headerLabel.text = name
    }
}
