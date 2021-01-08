//
//  InstructionTableViewCell.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/25/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Kingfisher
import Then

final class InstructionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    private var data: Step?
    
    func takeInstructionData( _ data: Step) {
        numberLabel.text = "Step \(data.number)"
        contentLabel.text = data.step
        self.data = data
        if data.ingredients.isEmpty && data.equiments.isEmpty {
            self.accessoryType = .none
        }
    }
}
