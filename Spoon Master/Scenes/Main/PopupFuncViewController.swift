//
//  PopupFuncViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 10/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol PopupDelegate: class {
    func favouriteVC()
    func logOut()
}

class PopupFuncViewController: UIViewController {

    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet var logOutButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    weak var delegate: PopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        favouriteButton.makeRoundCorner()
        logOutButton.makeRoundCorner()
        closeButton.makeRoundCorner()
    }
    
    @IBAction func favourite(_ sender: UIButton) {
        delegate?.favouriteVC()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        delegate?.logOut()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
