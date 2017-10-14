//
// Created by ukitaka on 2017/10/14.
//

// MARK: - or

import Utils

public extension Parser {
    public func or(_ other: @autoclosure @escaping () -> Parser<A>) -> Parser<A> {
        return Parser<A> { input in
            switch self.parse(input) {
            case let .success(a, remaining):
                return .success(a, remaining)
            case .failure:
                switch other().parse(input) {
                case let .success(a, remaining):
                    return .success(a, remaining)
                case .failure:
                    return .failure(.error("or error"))
                }
            }
        }
    }

    public static func <|> (lhs: Parser<A>, rhs: @autoclosure @escaping () -> Parser<A>) -> Parser<A> {
        return lhs.or(rhs)
    }
}

// MARK: - product

public extension Parser {
    public func product<B>(_ other: Parser<B>) -> Parser<(A, B)> {
        return map2(other) { (a, b) in (a, b) }
    }

    public static func <**> <B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<(A, B)> {
        return lhs.product(rhs)
    }
}

// MARK: - many

public extension Parser {
    public func listOf(_ n: UInt) -> Parser<[A]> {
        if n == 0 {
            return Parser<[A]>.success([])
        } else {
            return map2(self.listOf(n - 1), Array.cons)
        }
    }

    public func many() -> Parser<[A]> {
        return map2(self.many(), Array.cons) <|> Parser<[A]>.success([])
    }
}
