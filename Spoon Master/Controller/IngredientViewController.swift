//
//  IngredientViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 04/12/2020.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Then

final class IngredientViewController: UIViewController {
    
    @IBOutlet private weak var goToInstructionButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var data: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        trackingShowScreenImpression(eventName: Constant.EventName.ingredientImpression)
    }
    
    @IBAction func goToInstructionButton(_ sender: UIButton) {
        trackingButtonNext(eventName: Constant.EventButton.goNextScreen)
        let storyboard = UIStoryboard(name: Constant.Storyboard.instruction, bundle: nil)
        if let intructionVC = storyboard.instantiateViewController(withIdentifier: Constant.Identifier.instructionViewController) as?
            InstructionViewController,
            let newData = data {
            navigationController?.pushViewController(intructionVC, animated: true)
            intructionVC.takeInstructionData(newData.analyzedInstructions)
        }
    }
    
    func configView() {
        goToInstructionButton.layer.cornerRadius = goToInstructionButton.frame.height / 10
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UINib(nibName: Constant.Identifier.ingredientTableViewCell, bundle: nil),
                        forCellReuseIdentifier: Constant.Identifier.ingredientTableViewCell)
        }
    }
    
    func takeIngredientData(_ data: Recipe) {
        self.data = data
    }
}

// MARK: - UITableView Delegate
extension IngredientViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Height.heightForIngredientRow
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// MARK: - UITableView DataSource
extension IngredientViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.extendedIngredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.Identifier.ingredientTableViewCell, for: indexPath) as?
            IngredientTableViewCell else {
                return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.takeIngredientData(data?.extendedIngredients[indexPath.row])
        return cell
    }
}
