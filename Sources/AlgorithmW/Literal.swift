//
// Created by ukitaka on 2017/10/12.
//

public enum Literal {
    case int(Int)
    case bool(Bool)
}

// MARK: -

extension Literal: Equatable {
    public static func ==(lhs: Literal, rhs: Literal) -> Bool {
        switch (lhs, rhs) {
        case let (.int(i1), .int(i2)):
            return i1 == i2
        case let (.bool(b1), .bool(b2)):
            return b1 == b2
        default:
            return false
        }
    }
}

// MARK: -

extension Literal: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .int(n):
            return "\(n)"
        case let .bool(b):
            return "\(b)"
        }
    }
}
