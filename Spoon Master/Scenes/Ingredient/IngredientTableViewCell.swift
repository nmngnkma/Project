//
//  IngredientTableViewCell.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/24/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

final class IngredientTableViewCell: UITableViewCell {
        
    @IBOutlet private weak var ingredientImage: UIImageView!
    @IBOutlet private weak var ingreNameLabel: UILabel!
    @IBOutlet private weak var ingreAmountLabel: UILabel!
    @IBOutlet private weak var ingreOriginalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func takeIngredientData( _ data: ExtendedIngredient!) {
        let url = URL(string: data.imageUrl)
        ingredientImage.kf.setImage(with: url)
        ingreNameLabel.text = data.name
        ingreNameLabel.text?.capitalizeFirstLetter()
        if data.amount != 0 {
            ingreAmountLabel.text = "⑇ : \(data.amount) \(data.unit)"
        } 
        ingreOriginalLabel.text = data.originalString
    }
    
    func configView() {
        ingredientImage.makeRoundCorner()
        ingreAmountLabel.wrapContent()
    }
}
