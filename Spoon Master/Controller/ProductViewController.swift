//
//  ProductViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 04/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Kingfisher
import Then

final class ProductViewController: UIViewController {
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var moneyLabel: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var sizeLabel: UILabel!
    @IBOutlet private weak var summaryTextView: UITextView!
    
    private let repositories = Repositories(api: .share)
    private var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProductDetail()
        configView()
    }
    
    func getData( _ data: Item) {
        item = data
    }
    
    func configProductDetail() {
        repositories.takeProductDetail(productId: item?.itemId ?? 0) { [weak self] (result) in
            self?.fetchProductDetail(result)
        }
    }
    
    func fetchProductDetail(_ data: BaseResult<ProductDetail>) {
        switch data {
        case .success(let value):
            if let data = value {
                setupView(data)
            }
        case .failure(let error):
            print("Fetching product data has error : \(String(describing: error))")
        }
    }
    
    func setupView(_ data: ProductDetail) {
        let url = URL(string: data.images.first ?? "")
        productImageView.kf.setImage(with: url)
        productNameLabel.text = data.title
        scoreLabel.text = "\(data.spoonacularScore)"
        moneyLabel.text = "\(data.price)"
        likeLabel.text = "\(data.likes)"
        if data.servingSize.isEmpty == false {
            sizeLabel.text = "\(data.servingSize)"
        } else {
            sizeLabel.text = " None "
        }
        summaryTextView.text = data.description
        summaryTextView.text = data.description.htmlToString
    }
    
    func configView() {
        summaryTextView.isEditable = false
        sizeLabel.wrapContent()
    }
}
