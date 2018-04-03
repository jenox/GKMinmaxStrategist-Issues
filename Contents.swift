import GameplayKit

public class Game: AbstractTwoPlayerGame<AbstractMove> {
    public override func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        precondition(player === self.activePlayer)

        // min/max scores indicate the game is over
        if [GKGameModelMinScore, GKGameModelMaxScore].contains(self.player1Score()) {
            return []
        }
        else {
            return [1,2].map({ AbstractMove(identifier: $0) })
        }
    }

    private func player1Score() -> Int {
        let moves = self.moves.map({ $0.identifier })

        // Winning/losing positions
        switch moves {
        case [1]: return GKGameModelMaxScore // win
        case [2,1]: return GKGameModelMaxScore // win
        case [2,2]: return GKGameModelMinScore // loss

        // No winning/losing position, explore deeper.
        default: return 0
        }
    }

    public override func score(for player: GKGameModelPlayer) -> Int {
        let moves = self.moves.map({ $0.identifier })
        let score: Int

        if player === self.player1 {
            score = self.player1Score()
        }
        else {
            score = -self.player1Score()
        }

        print("score(\(moves), P\(player.playerId)) = \(score)")

        return score
    }
}


do {
    let player1 = AbstractPlayer(playerId: 1)
    let player2 = AbstractPlayer(playerId: 2)
    let game = Game(player1: player1, player2: player2)

    let strategist = GKMinmaxStrategist()
    strategist.maxLookAheadDepth = 3

    print("Active player: P\(game.activePlayer!.playerId)")
    print()

    print("Evaluated positions:")
    strategist.gameModel = game
    let move = strategist.bestMoveForActivePlayer() as! AbstractMove

    print()
    print("Strategist would perform \(move.identifier)")
}
