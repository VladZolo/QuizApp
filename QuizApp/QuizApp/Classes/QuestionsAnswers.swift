//
//  QuestionsAnswers.swift
//  QuizApp
//
//  Created by Vladislav Zolotov on 2023-07-25.
//

import UIKit

class QuestionsAnswers {
    
    let question: Question
    var answer: Answer
    
    init(question: Question, answer: Answer) {
        self.question = question
        self.answer = answer
    }
    
    let answersForQuestion1 = [
        answer(content: "Option 1", isCorrect: true),
        answer(content: "Option 2", isCorrect: false),
        answer(content: "Option 3", isCorrect: false),
        answer(content: "Option 4", isCorrect: false)
    ]

    // Create the first question
    let question1 = Question(content: "What is 2 + 2?", answers: answersForQuestion1)

    // Create the answers for the second question
    let answersForQuestion2 = [
        Answer(content: "Answer A", isCorrect: false),
        Answer(content: "Answer B", isCorrect: true),
        Answer(content: "Answer C", isCorrect: false),
        Answer(content: "Answer D", isCorrect: false)
    ]

    // Create the second question
    let question2 = Question(content: "What is the capital of France?", answers: answersForQuestion2)

    // Add more questions and answers as needed

    // Create an array to hold all the questions
    let questions = [question1, question2]
}
