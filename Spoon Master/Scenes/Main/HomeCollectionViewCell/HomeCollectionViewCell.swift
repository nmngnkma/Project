//
//  HomeCollectionViewCell2.swift
//  Spoon Master
//
//  Created by Nam Ngây on 25/12/2020.
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
    
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    
    func configDataCell( _ data: DataCell) {
        switch data {
        case .productsCell(let item):
            foodNameLabel.text = "   \(item.title)"
            let url = URL(string: item.image)
            foodImageView.kf.setImage(with: url)
        case .recipesCell(let recipe):
            foodNameLabel.text = "   \(recipe.title)"
            let url = URL(string: recipe.image)
            foodImageView.kf.setImage(with: url)
        }
    }
    
    func configCell() {
        foodImageView.layer.do {
            $0.cornerRadius = $0.frame.height / 10.0
            $0.masksToBounds = true
            $0.cornerRadius = 8
            $0.shadowColor = UIColor.black.cgColor
            $0.shadowOpacity = 0.1
            $0.shadowOffset = CGSize(width: 0,height: 2)
            $0.shadowRadius = 8
            
        }
    }
     
}
