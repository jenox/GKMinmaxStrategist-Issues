import GameplayKit


open class AbstractTwoPlayerGame<Move: GKGameModelUpdate>: NSObject, GKGameModel {
    public required init(player1: GKGameModelPlayer, player2: GKGameModelPlayer) {
        self.player1 = player1
        self.player2 = player2
        self.moves = []
    }

    private(set) public final var player1: GKGameModelPlayer
    private(set) public final var player2: GKGameModelPlayer
    private(set) public final var moves: [Move]

    public final var players: [GKGameModelPlayer]? {
        return [self.player1, self.player2]
    }

    public final var activePlayer: GKGameModelPlayer? {
        return (self.moves.count % 2 == 0) ? self.player1 : self.player2
    }

    public final var inactivePlayer: GKGameModelPlayer {
        return (self.moves.count % 2 == 0) ? self.player2 : self.player1
    }

    public final func copy(with zone: NSZone? = nil) -> Any {
        let copy = type(of: self).init(player1: self.player1, player2: self.player2)
        copy.moves = self.moves

        return copy
    }

    public final func setGameModel(_ model: GKGameModel) {
        let model = model as! AbstractTwoPlayerGame

        self.player1 = model.player1
        self.player2 = model.player2
        self.moves = model.moves
    }

    public final func apply(_ update: GKGameModelUpdate) {
        let move = update as! Move

        self.moves.append(move)
    }

    public final func unapplyGameModelUpdate(_ update: GKGameModelUpdate) {
        precondition(self.moves.last === update)

        self.moves.removeLast()
    }

    open func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        return []
    }

    open func score(for player: GKGameModelPlayer) -> Int {
        return 0
    }
}
