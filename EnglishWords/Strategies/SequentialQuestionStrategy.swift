//
//  SequentialQuestionStrategy.swift
//  EnglishWords
//
//  Created by USER on 2020/05/18.
//  Copyright © 2020 Sangmin. All rights reserved.
//

import Foundation

final class SequentialQuestionStrategy: QuestionStrategy {
    var correctCount: Int = 0
    var incorrectCount: Int = 0
    
    let questionGroup: QuestionGroup
    var questionIndex = 0
    
    var title: String {
        return questionGroup.title
    }
    
    init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }
    
    func currentQuestion() -> Question {
        return questionGroup.questions[questionIndex]
    }
    
    func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questionGroup.questions.count else {
            return false
        }
        
        questionIndex += 1
        
        return true
    }
    
    func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    
    func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }
    
    func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/" +
        "\(questionGroup.questions.count)"
    }
}
