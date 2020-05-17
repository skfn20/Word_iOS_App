//
//  QuestionStrategy.swift
//  EnglishWords
//
//  Created by USER on 2020/05/18.
//  Copyright © 2020 Sangmin. All rights reserved.
//

import Foundation

protocol QuestionStrategy: class {
    var title: String { get }
    
    var correctCount: Int { get }
    var incorrectCount: Int { get }
    
    func advanceToNextQuestion() -> Bool
    
    func currentQuestion() -> Question
    
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)
    
    func questionIndexTitle() -> String 
}
