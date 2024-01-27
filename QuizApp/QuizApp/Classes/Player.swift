
import UIKit

class Player {
    let userName: String
    var points: Int = 0
    var completedQuizesCount: Int = 0
    var correctAnswersCount: Int = 0
    var questionEnduredCount: Int = 0
    
    init(userName: String) {
        self.userName = userName
    }
    
    func answerAccuracy() -> Int {
        return (correctAnswersCount * 100) / questionEnduredCount
    }
    
    func completeQuiz(points: Int, correctAnswersCount: Int, questionEnduredCount: Int, completedQuizesCount: Int) {
        self.points += points
        self.correctAnswersCount += correctAnswersCount
        self.questionEnduredCount += questionEnduredCount
        self.completedQuizesCount += completedQuizesCount
    }
}
