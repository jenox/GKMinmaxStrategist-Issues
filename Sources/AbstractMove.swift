import GameplayKit


public class AbstractMove: NSObject, GKGameModelUpdate {
    public init(identifier: Int) {
        self.identifier = identifier
    }

    public let identifier: Int
    public var value: Int = 0
}
