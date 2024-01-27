//
//  QuizData.swift
//  QuizApp
//
//  Created by Vladislav Zolotov on 2023-07-25.
//

import Foundation

class QuizData {
    
    func hardcodedQuestions() -> [Question] {
        let answersForQuestion1 = [
            Answer(content: "Option 1", isCorrect: true),
            Answer(content: "Option 2", isCorrect: false),
            Answer(content: "Option 3", isCorrect: false),
            Answer(content: "Option 4", isCorrect: false)
        ]
        
        let question1 = Question(content: "What is 2 + 2?", answers: answersForQuestion1)
        
        let answersForQuestion2 = [
            Answer(content: "Answer A", isCorrect: false),
            Answer(content: "Answer B", isCorrect: true),
            Answer(content: "Answer C", isCorrect: false),
            Answer(content: "Answer D", isCorrect: false)
        ]
        
        let question2 = Question(content: "What is the capital of France?", answers: answersForQuestion2)
        
        let questions = [question1, question2]
        return questions
    }
}
