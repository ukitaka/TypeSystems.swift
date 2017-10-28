//
// Created by ukitaka on 2017/10/13.
//

public enum ParseResult<A> {
    case success(A, String)
    case failure(ParseError)
}

public extension ParseResult {
    public func map<B>(_ f: @escaping (A, String) -> (B, String)) -> ParseResult<B> {
        switch self {
        case let .success(a, remaining1):
            let (b, remaining2) = f(a, remaining1)
            return .success(b, remaining2)
        case let .failure(error):
            return .failure(error)
        }
    }

    public func flatMap<B>(_ f: @escaping (A, String) -> ParseResult<B>) -> ParseResult<B> {
        switch self {
        case let .success(a, remaining):
            return f(a, remaining)
        case let .failure(error):
            return .failure(error)
        }
    }
}

extension ParseResult: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .success(a, input):
            return ".success(\(a), \(input)"
        case let .failure(.error(message)):
            return ".failure(\(message)"
        }
    }
}
