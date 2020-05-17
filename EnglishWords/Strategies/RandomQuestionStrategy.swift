//
//  RandomQuestionStrategy.swift
//  EnglishWords
//
//  Created by USER on 2020/05/18.
//  Copyright © 2020 Sangmin. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

final class RandomQuestionStrategy: QuestionStrategy {
    var correctCount: Int = 0
    var incorrectCount: Int = 0
    var questionIndex = 0
    
    let questionGroup: QuestionGroup
    let questions: [Question]
    
    var title: String {
        return questionGroup.title
    }
    
    init(questionGroup: QuestionGroup) {
        let randomSource = GKRandomSource.sharedRandom()
        
        self.questionGroup = questionGroup
        self.questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
    }
    
    func currentQuestion() -> Question {
        return questions[questionIndex]
    }
    
    func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questions.count else {
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
        return "\(questionIndex + 1)/\(questions.count)"
    }
    
    
}
