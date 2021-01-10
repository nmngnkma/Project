//
//  StepHeaderView.swift
//  Spoon Master
//
//  Created by Nam Ngây on 09/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import UIKit

final class StepHeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var headerLabel: UILabel!
    
    func setupName( _ name: String) {
        headerLabel.text = name
    }
}
