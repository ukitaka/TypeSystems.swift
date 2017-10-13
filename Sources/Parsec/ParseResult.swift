//
// Created by ukitaka on 2017/10/13.
//

public enum ParseResult<A> {
    case success(A, String)
    case failure(ParseError)
}

public extension ParseResult {
    public func map<B>(_ f: @escaping (A) -> B) -> ParseResult<B> {
        switch self {
        case let .success(a, remaining):
            return .success(f(a), remaining)
        case let .failure(error):
            return .failure(error)
        }
    }

    public func flatMap<B>(_ f: @escaping (A) -> ParseResult<B>) -> ParseResult<B> {
        switch self {
        case let .success(a, _):
            return f(a)
        case let .failure(error):
            return .failure(error)
        }
    }
}
