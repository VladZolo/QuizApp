//
//  GameViewController.swift
//  QuizApp
//
//  Created by Vladislav Zolotov on 2023-07-25.
//

import UIKit

class GameViewController: UIViewController {
    
    let questionsRepository = QuestionsRepository()
    var quizManager: QuizManager = QuizManager(questions: [])
    let playerManager: PlayerManager
    var score = 0
    var questionEnduredCount = 0
    var correctAnswersCount = 0
    
    init(playerManager: PlayerManager) {
        self.playerManager = playerManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var questionTextField: UITextView!
    @IBOutlet weak var firstAnswerButtonLabel: UIButton!
    @IBOutlet weak var secondAnswerButtonLabel: UIButton!
    @IBOutlet weak var thirdAnswerButtonLabel: UIButton!
    @IBOutlet weak var fourthAnswerButtonLabel: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var resultInformationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsRepository.getQuestions { [unowned self] questions in
            let quizManager = QuizManager(questions: questions)
            self.quizManager.questions = quizManager.questions
            self.loadQuestion()
        }
        //        hardcodedQuestions()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func firstAnswerButtonTappeda(_ sender: Any) {
        if quizManager.loadQuestion().answers[0].isCorrect {
            handleAnswer(isCorrect: true)
        } else {
            handleAnswer(isCorrect: false)
        }
        if quizManager.isLastQuestion() {
            saveResult()
            showResultAlert()
        }
        guard quizManager.currentQuestionIndex == 5 else {
            return loadQuestion()
        }
    }
    
    @IBAction func secondAnswerButtonTappeda(_ sender: Any) {
        if quizManager.loadQuestion().answers[1].isCorrect {
            handleAnswer(isCorrect: true)
        } else {
            handleAnswer(isCorrect: false)
        }
        if quizManager.isLastQuestion() {
            saveResult()
            showResultAlert()
        }
        guard quizManager.currentQuestionIndex == 5 else {
            return loadQuestion()
        }
    }
    
    @IBAction func thirdAnswerButtonTappeda(_ sender: Any) {
        if quizManager.loadQuestion().answers[2].isCorrect {
            handleAnswer(isCorrect: true)
        } else {
            handleAnswer(isCorrect: false)
        }
        if quizManager.isLastQuestion() {
            saveResult()
            showResultAlert()
        }
        guard quizManager.currentQuestionIndex == 5 else {
            return loadQuestion()
        }
    }
    
    @IBAction func fourthAnswerButtonTappeda(_ sender: Any) {
        if quizManager.loadQuestion().answers[3].isCorrect {
            handleAnswer(isCorrect: true)
        } else {
            handleAnswer(isCorrect: false)
        }
        if quizManager.isLastQuestion() {
            saveResult()
            showResultAlert()
        }
        guard quizManager.currentQuestionIndex == 5 else {
            return loadQuestion()
        }
    }
    
    //    func hardcodedQuestions() {
    //        let hardcodedQuestion1 =  Question(content: "Klausimas1?", answers: [Answer(content: "Atsakymas1", isCorrect: false), Answer(content: "Atsakymas2", isCorrect: false), Answer(content: "Atsakymas3", isCorrect: false), Answer(content: "TRUE", isCorrect: true)])
    //        let hardcodedQuestion2 =  Question(content: "Question2?", answers: [Answer(content: "Answer1", isCorrect: false), Answer(content: "Answer2", isCorrect: false), Answer(content: "TRUE", isCorrect: true), Answer(content: "Answer4", isCorrect: false)])
    //        let hardcodedQuestion3 =  Question(content: "Klausimas3?", answers: [Answer(content: "TRUE", isCorrect: true), Answer(content: "A2", isCorrect: false), Answer(content: "A3", isCorrect: false), Answer(content: "A4", isCorrect: false)])
    //        let hardcodedQuestion4 =  Question(content: "Question4?", answers: [Answer(content: "Option1", isCorrect: false), Answer(content: "TRUE", isCorrect: true), Answer(content: "Option3", isCorrect: false), Answer(content: "Option4", isCorrect: false)])
    //        let hardcodedQuestion5 =  Question(content: "Klausimas5?", answers: [Answer(content: "TRUE", isCorrect: true), Answer(content: "2", isCorrect: false), Answer(content: "3", isCorrect: false), Answer(content: "4", isCorrect: false)])
    //        self.quizManager.questions = [hardcodedQuestion1, hardcodedQuestion2, hardcodedQuestion3, hardcodedQuestion4, hardcodedQuestion5]
    //    }
    
    func loadQuestion() {
        questionTextField.text = quizManager.questions[quizManager.currentQuestionIndex].content
        firstAnswerButtonLabel.setTitle("\(quizManager.questions[quizManager.currentQuestionIndex].answers[0].content)", for: .normal)
        secondAnswerButtonLabel.setTitle("\(quizManager.questions[quizManager.currentQuestionIndex].answers[1].content)", for: .normal)
        thirdAnswerButtonLabel.setTitle("\(quizManager.questions[quizManager.currentQuestionIndex].answers[2].content)", for: .normal)
        fourthAnswerButtonLabel.setTitle("\(quizManager.questions[quizManager.currentQuestionIndex].answers[3].content)", for: .normal)
    }
    
    func handleAnswer(isCorrect: Bool) {
        var points = 0
        if isCorrect {
            score += quizManager.calculatePoints(answeredCorrectly: true)
            questionEnduredCount += 1
            correctAnswersCount += 1
            pointsLabel.text = "Points: \(score)"
            points = quizManager.pointsForQuestion * quizManager.correctStreak
            resultInformationLabel.textColor = .green
            resultInformationLabel.text = "Correct! You got \(points) points"
        } else {
            score += quizManager.calculatePoints(answeredCorrectly: false)
            questionEnduredCount += 1
            pointsLabel.text = "Points: \(score)"
            points = quizManager.pointsForQuestion * -quizManager.incorrectStreak
            resultInformationLabel.textColor = .red
            resultInformationLabel.text = "Incorrect! You lost \(points) points"
        }
    }
    
    func saveResult() {
        playerManager.currentPlayer.completeQuiz(points: score, correctAnswersCount: correctAnswersCount, questionEnduredCount: questionEnduredCount, completedQuizesCount: 1)
    }
    
    func showResultAlert() {
        let alert = UIAlertController(title: "Quiz information", message: "Congratulations! You have ended the quiz.\n\nYou have collected: \(score) points", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("StartOver", comment: "Default action"), style: .default, handler: { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
