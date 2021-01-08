//
//  StepTableViewCell.swift
//  Spoon Master
//
//  Created by Nam Ngây on 1/9/21.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Kingfisher

final class StepTableViewCell: UITableViewCell {

    @IBOutlet private weak var stepImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func setupView( _ data: Ingredient) {
        let url = URL(string: data.ingredientImage)
        stepImage.kf.setImage(with: url)
        stepImage.makeRoundCorner()
        titleLabel.text = data.localizedName
        titleLabel.wrapContent()
    }
    func setUpView( _ data: Equipment) {
        let url = URL(string: data.equipmentImage)
        stepImage.kf.setImage(with: url)
        stepImage.makeRoundCorner()
        titleLabel.text = data.localizedName
        titleLabel.wrapContent()
    }
}
