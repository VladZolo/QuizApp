
import UIKit

class PlayerManager {
    var players: [Player] = []
    var currentPlayer = Player(userName: "")
    
    func join(userName: String) {
        if let user = players.first(where: { $0.userName == userName }) {
            currentPlayer = user
        } else {
            let newUser = Player(userName: userName)
            players.append(newUser)
            currentPlayer = newUser
        }
    }
}

