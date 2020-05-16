//
//  SelectQuestionGroupViewController.swift
//  EnglishWords
//
//  Created by USER on 2020/05/16.
//  Copyright © 2020 Sangmin. All rights reserved.
//

import UIKit

final class SelectQuestionGroupViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            let nibName = UINib(nibName: "QuestionGroupCell", bundle: nil)
            
            tableView.register(nibName, forCellReuseIdentifier: "QuestionGroupCell")
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Properties
    let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: -UITableViewDelegate

extension SelectQuestionGroupViewController: UITableViewDelegate {
    
    func tableView(_ tableVIew: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = QuestionViewController.make(withDependency: ())
        
        viewController.questionGroup = selectedQuestionGroup
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SelectQuestionGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as? QuestionGroupCell else {
            return QuestionGroupCell()
        }
        
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        
        return cell
    }
}

// MARK: - QuestionViewControllerDelegate

extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }
}
