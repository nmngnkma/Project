//
//  FavoriteTableViewCell.swift
//  Spoon Master
//
//  Created by Nam Ngây on 1/3/21.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet private weak var favImage: UIImageView!
    @IBOutlet private weak var favNameLabel: UILabel!
    
    func setupView( _ data: FavoriteRecipe) {
        let url = URL(string: data.image ?? "")
        favImage.kf.setImage(with: url)
        favImage.makeRoundCorner()
        favNameLabel.text = data.name
        favNameLabel.wrapContent()
    }
    
}
