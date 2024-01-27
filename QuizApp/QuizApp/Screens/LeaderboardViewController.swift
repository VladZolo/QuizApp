//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Vladislav Zolotov on 2023-07-26.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    @IBOutlet weak var firstPlayerNameLabel: UIButton!
    @IBOutlet weak var secondPlayerNameLabel: UIButton!
    @IBOutlet weak var thirdPlayerNameLabel: UIButton!
    
    let playerManager: PlayerManager
    
    init(playerManager: PlayerManager) {
        self.playerManager = playerManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rankByScore()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func loadUsers(player: Player, rank: Int) {
        let playerName = player.userName
        let playerPoints = player.points
        
        switch rank {
        case 1:
            firstPlayerNameLabel.setTitle("\(playerName) \(playerPoints)", for: .normal)
            firstPlayerNameLabel.isHidden = false
        case 2:
            secondPlayerNameLabel.setTitle("\(playerName) \(playerPoints)", for: .normal)
            secondPlayerNameLabel.isHidden = false
        case 3:
            thirdPlayerNameLabel.setTitle("\(playerName) \(playerPoints)", for: .normal)
            thirdPlayerNameLabel.isHidden = false
        default:
            break
        }
    }
    
    func rankByScore() {
        let rankedPlayers = playerManager.players.sorted(by: { $0.points > $1.points })
        for (index, player) in rankedPlayers.enumerated() {
            loadUsers(player: player, rank: index + 1)
        }
    }
    
    func showUserInfoAlert(player: Player) {
        let message = "Correct answer accuracy: \(player.answerAccuracy())%\nCompleted Quizes: \(player.completedQuizesCount)"
        let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func extractPlayerName(from button: UIButton) -> String {
        if let title = button.title(for: .normal),
           let index = title.firstIndex(of: " ") {
            return String(title[..<index])
        }
        return ""
    }
    
    @IBAction func goldUsernameLabelTapped(_ sender: Any) {
        let playerName = extractPlayerName(from: firstPlayerNameLabel)
        if let player = playerManager.players.first(where: { $0.userName == playerName }) {
            showUserInfoAlert(player: player)
        }
    }
    
    @IBAction func silverUsernameLabelTapped(_ sender: Any) {
        let playerName = extractPlayerName(from: secondPlayerNameLabel)
        if let player = playerManager.players.first(where: { $0.userName == playerName }) {
            showUserInfoAlert(player: player)
        }
    }
    
    @IBAction func bronzeUsernameLabelTapped(_ sender: Any) {
        let playerName = extractPlayerName(from: secondPlayerNameLabel)
        if let player = playerManager.players.first(where: { $0.userName == playerName }) {
            showUserInfoAlert(player: player)
        }
    }
}
