//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Vladislav Zolotov on 2023-07-25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
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
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter username", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        guard userNameTextField.text != "" else {
            return showAlert()
        }
        if let userName = userNameTextField.text {
            playerManager.join(userName: userName)
        }
        let gameViewController = GameViewController(playerManager: playerManager)
        navigationController?.pushViewController(gameViewController, animated: true)
    }
}
