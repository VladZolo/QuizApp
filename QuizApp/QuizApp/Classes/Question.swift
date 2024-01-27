
import UIKit

class Question {
    let content: String
    let answers: [Answer]
    
    init(content: String, answers: [Answer]) {
        self.content = content
        self.answers = answers
    }
}
