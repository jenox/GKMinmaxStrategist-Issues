import GameplayKit


public class AbstractPlayer: NSObject, GKGameModelPlayer {
    public init(playerId: Int) {
        self.playerId = playerId
    }

    public let playerId: Int
}
