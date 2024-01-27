
import Foundation

private struct APIResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case response_code
        case results
    }
    
    let response_code: Int
    let results: [QuestionJSON]
}

private struct QuestionJSON: Decodable {
    enum CodingKeys: String, CodingKey {
        case category
        case correct_answer
        case incorrect_answers
        case question
    }
    
    let category: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let question: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category = try container.decode(String.self, forKey: .category).removingPercentEncoding!
        correctAnswer = try container.decode(String.self, forKey: .correct_answer).removingPercentEncoding!
        question = try container.decode(String.self, forKey: .question).removingPercentEncoding!
        
        let encodedIncorrectAnswers = try container.decode([String].self, forKey: .incorrect_answers)
        var decodedIncorrectAnswers = [String]()
        
        for encodedIncorrectAnswer in encodedIncorrectAnswers {
            decodedIncorrectAnswers.append(encodedIncorrectAnswer.removingPercentEncoding!)
        }
        incorrectAnswers = decodedIncorrectAnswers
    }
}

final class QuestionsRepository {
    func getQuestions(completion: @escaping ([Question]) -> Void) {
        let apiURL = URL(string: "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple&encode=url3986")
        let request = URLRequest(url: apiURL!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { [unowned self] data, _, _ -> Void in
            do {
                let response: APIResponse = try! JSONDecoder().decode(APIResponse.self, from: data!)
                DispatchQueue.main.async {
                    completion(self.parseQuestionsFromResponse(response))
                }
            }
        })
        task.resume()
    }
    
    private func parseQuestionsFromResponse(_ response: APIResponse) -> [Question] {
        var questions: [Question] = []
        
        for questionJSON in response.results {
            var allAnswers = questionJSON.incorrectAnswers
            allAnswers.append(questionJSON.correctAnswer)
            allAnswers.shuffle()
            
            let answers = allAnswers.map { content in
                let isCorrect = content == questionJSON.correctAnswer
                return Answer(content: content, isCorrect: isCorrect)
            }
            
            let question = Question(
                content: questionJSON.question,
                answers: answers
            )
            questions.append(question)
        }
        return questions
    }
}
