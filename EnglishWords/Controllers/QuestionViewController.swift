//
//  ViewController.swift
//  EnglishWords
//
//  Created by USER on 2020/05/10.
//  Copyright © 2020 Sangmin. All rights reserved.
//

import UIKit

protocol QuestionViewControllerDelegate: class {
    
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy, at questionIndex: Int)
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy)
}

final class QuestionViewController: UIViewController {
    
    @IBOutlet weak var inCorrectBtn: UIButton!
    @IBOutlet weak var correctBtn: UIButton!
    
    weak var delegate: QuestionViewControllerDelegate?
    
    var questionStrategy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStrategy.title 
        }
    }

    var questionIndex = 0
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        return item
    }()
    
    var correctCount = 0
    var incorrectCount = 0
    
    var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
}

// MARK: - Private Method

extension QuestionViewController {
    
    private func setUpView() {
        let toggleGesture = UITapGestureRecognizer(target: self,
                                                   action: #selector(toggleAnswerLabels(_:)))
        
        self.view.addGestureRecognizer(toggleGesture)
        
        inCorrectBtn.addTarget(self, action: #selector(handleInCorrect(_:)), for: .touchUpInside)
        correctBtn.addTarget(self, action: #selector(handleCorrect(_:)), for: .touchUpInside)
        
        showQuestion()
    }
    
    private func showQuestion() {
        let question = questionStrategy.currentQuestion()

        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint

        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionStrategy.advanceToNextQuestion() else {
            let title = "더 이상 풀 문제가 없습니다.."
            let message = "그만하시겠습니까?"
            
            showToast(viewController: self, title: title, message: message)
            
            return
        }
        
        showQuestion()
    }
    
    private func showToast(viewController vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.delegate?.questionViewController(self, didComplete: self.questionStrategy)
        }
        
        alert.addAction(okButton)
        vc.present(alert, animated: false, completion: nil)
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                            landscapeImagePhone: nil,
                                                            style: .plain,
                                                            target: self,
                                                            action: action)
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionStrategy, at: questionIndex)
    }
}

// MARK: - Actions

extension QuestionViewController {
    
    @objc private func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @objc private func handleCorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        
        questionStrategy.markQuestionCorrect(question)
        questionView.correctCountLabel.text = String(questionStrategy.correctCount)

        
        showNextQuestion()
    }
    
    @objc private func handleInCorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        
        questionStrategy.markQuestionIncorrect(question)
        questionView.incorrectCountLabel.text = String(questionStrategy.incorrectCount)
        
        showNextQuestion()
    }
}

extension QuestionViewController: DependencyInjectable {
    typealias Dependency = QuestionStrategy
    
    static func make(withDependency dependency: Dependency) -> QuestionViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        
        viewController.questionStrategy = dependency
        
        return viewController
    }
}
