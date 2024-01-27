
import UIKit

class ViewController: UIViewController {
    
    let playerManager: PlayerManager = PlayerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startGameButtonTapped(_ sender: Any) {
        let loginViewController = LoginViewController(playerManager: playerManager)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func leaderboardButtonTapped(_ sender: Any) {
        let leaderboardViewController = LeaderboardViewController(playerManager: playerManager)
        navigationController?.pushViewController(leaderboardViewController, animated: true)
    }
}

