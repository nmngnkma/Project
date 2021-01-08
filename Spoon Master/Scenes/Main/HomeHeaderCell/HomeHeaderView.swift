//
//  HomeHeaderView.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/16/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

final class HomeHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var category: UILabel!
    
    func setupName(sectionTitle: String) {
        category.text = sectionTitle
        category.layer.do {
            $0.cornerRadius = 8
        }
    }
    
    func setupToggle(_ check: Bool) {
        switch check {
        case true:
            contentView.backgroundColor = .black
            category.backgroundColor = .black
        default:
            contentView.backgroundColor = .white
            category.backgroundColor = .white
        }
    }
}
