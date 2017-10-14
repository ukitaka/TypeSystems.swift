//
// Created by ukitaka on 2017/10/13.
//

public enum ParseError: Error {
    case error(String)
}

extension ParseError: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .error(message):
            return message
        }
    }
}
