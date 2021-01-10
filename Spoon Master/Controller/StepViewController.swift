//
//  StepTableViewCell.swift
//  Spoon Master
//
//  Created by Nam Ngây on 09/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import UIKit

final class StepViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var steps: Step?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        trackingShowScreenImpression(eventName:  Constant.EventName.stepImpression)
    }
    
    func configView() {
        tableView.do {
            $0.tableFooterView = UIView()
            $0.delegate = self
            $0.dataSource = self
            $0.register(UINib(nibName: "StepTableViewCell", bundle: nil), forCellReuseIdentifier: "StepTableViewCell")
            $0.register(UINib(nibName: "StepHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "StepHeaderView")
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 100
        }
    }
    
    func getStepData( _ step: Step) {
        steps = step
    }
}

// MARK: - UITableView Delegate
extension StepViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableView DataSource
extension StepViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let step = steps {
            if section == 0 {
                return step.ingredients.count
            } else {
                return step.equiments.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StepTableViewCell", for: indexPath) as? StepTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if let step = steps {
            switch indexPath.section {
            case 0:
                cell.setupView(step.ingredients[indexPath.row])
            default:
                cell.setUpView(step.equiments[indexPath.row])
            }
        }
        return cell
    }
    
    // MARK: - Custom Header
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let step = steps {
            if step.ingredients.isEmpty {
                switch section {
                case 0:
                    return 0
                default:
                    return Constant.Height.heightOfHeaderInSection
                }
            }
        }
        return Constant.Height.heightOfHeaderInSection
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "StepHeaderView") as?
            StepHeaderView else {
                return UIView()
        }
        if let step = steps {
            switch section {
            case 0:
                if step.ingredients.isEmpty {
                    header.setupName("")
                } else {
                    header.setupName("Ingredient")
                }
            case 1:
                if step.equiments.isEmpty {
                    header.setupName("")
                } else {
                    header.setupName("Equipment")
                }
            default:
                break
            }
        }
        return header
    }
}
