//
//  SearchResultTableViewCell.swift
//  Spoon Master
//
//  Created by Nam Ngây on 07/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import UIKit

final class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var resultImageView: UIImageView!
    @IBOutlet private weak var resultNameLabel: UILabel!
    
    func setupView(_ result: Results) {
        let url = URL(string: result.image)
        resultImageView.kf.setImage(with: url)
        resultImageView.makeRoundCorner()
        resultNameLabel.text = result.title
        resultNameLabel.wrapContent()
    }
    
    func setUpView(_ item: Item) {
        let url = URL(string: item.image)
        resultImageView.kf.setImage(with: url)
        resultImageView.makeRoundCorner()
        resultNameLabel.text = item.title
        resultNameLabel.wrapContent()
    }
    
}
