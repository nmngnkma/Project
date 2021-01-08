//
//  CollectionViewCell.swift
//  Spoon Master
//
//  Created by Nam Ngây on 6/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Kingfisher
import Then

enum DataCell {
    case recipesCell(Recipe)
    case productsCell(Item)
}

final class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var avatarOfFood: UIImageView!
    @IBOutlet private weak var nameOfFood: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarOfFood.do {
            $0.layer.cornerRadius = $0.frame.height / 10.0
            $0.layer.masksToBounds = true
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowOffset = CGSize.zero
            $0.layer.shadowRadius = 10
        }
    }
    
    func configDataCell( _ data: DataCell) {
        switch data {
        case .productsCell(let item):
            nameOfFood.text = "   \(item.title)"
            let url = URL(string: item.image)
            avatarOfFood.kf.setImage(with: url)
        case .recipesCell(let recipe):
            nameOfFood.text = "   \(recipe.title)"
            let url = URL(string: recipe.image)
            avatarOfFood.kf.setImage(with: url)
        }
    }
}
