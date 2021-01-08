//
//  InstructionViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Then

final class InstructionViewController: UIViewController {
        
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var doneButton: UIButton!
    
    private var analyzedInstructionData = [AnalyzedInstruction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        doneButton.layer.cornerRadius = doneButton.frame.height / 10
        tableView.do {
            $0.tableFooterView = UIView()
            $0.delegate = self
            $0.dataSource = self
            $0.register(UINib(nibName: Constant.Identifier.instructionTableViewCell, bundle: nil),
                        forCellReuseIdentifier: Constant.Identifier.instructionTableViewCell)
            $0.register(UINib(nibName: Constant.Identifier.instructionHeaderFooterView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constant.Identifier.instructionHeaderFooterView)
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = Constant.Height.estimateHeightInstruction
            }
    }
    
    func takeInstructionData( _ analyzedInstructions: [AnalyzedInstruction]) {
        analyzedInstructionData = analyzedInstructions
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Congratulations",
                                      message: "See you in next recipe",
                                      preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + Constant.Time.timeToDismiss
        DispatchQueue.main.asyncAfter(deadline: when) {
            if let controllers = self.navigationController?.viewControllers {
                for view in controllers {
                    if view is DetailViewController {
                        self.navigationController?.popToViewController(view, animated: true)
                    }
                }
            }
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UITableView Delegate
extension InstructionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let step = analyzedInstructionData[indexPath.section].steps[indexPath.row]
        if step.ingredients.isEmpty == false || step.equiments.isEmpty == false {
            let storyboard = UIStoryboard(name: "StepView", bundle: nil)
            guard let stepVC = storyboard.instantiateViewController(withIdentifier: "StepViewController") as? StepViewController else { return }
            stepVC.getStepData(step)
            navigationController?.pushViewController(stepVC, animated: true)
        } else {
            return
        }
    }
}

// MARK: - UITableView DataSource
extension InstructionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return analyzedInstructionData[section].steps.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            Constant.Identifier.instructionTableViewCell, for: indexPath) as?
            InstructionTableViewCell else {
            return UITableViewCell()
        }
        let instruction = analyzedInstructionData[indexPath.section]
        cell.takeInstructionData(instruction.steps[indexPath.row])
        return cell
    }
    // MARK: - Custom Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return analyzedInstructionData.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch analyzedInstructionData[section].name {
        case "":
            return 0
        default:
            return 44
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.tableView.dequeueReusableHeaderFooterView(
            withIdentifier: Constant.Identifier.instructionHeaderFooterView) as?
            InstructionHeaderFooterView else {
                return UIView()
        }
        header.setupSectionName(analyzedInstructionData[section].name)
        return header
    }
}
