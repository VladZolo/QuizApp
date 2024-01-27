
import UIKit

class QuizManager {
    var questions: [Question]
    let pointsForQuestion: Int = 2
    var correctStreak: Int = 0
    var incorrectStreak: Int = 0
    var currentQuestionIndex: Int = 0
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    func loadQuestion() -> Question {
        let question = questions[currentQuestionIndex]
        currentQuestionIndex += 1
        return question
    }
    
    func isLastQuestion() -> Bool {
        return currentQuestionIndex == 5
    }
    
    func calculatePoints(answeredCorrectly: Bool) -> Int {
        if answeredCorrectly {
            incorrectStreak = 0
            correctStreak += 1
            return pointsForQuestion * correctStreak
        } else {
            correctStreak = 0
            incorrectStreak += 1
            return pointsForQuestion * -incorrectStreak
        }
    }
}
