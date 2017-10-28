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
                case let .failure(error):
                    return .failure(error)
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
    public func product<B>(_ other: @autoclosure @escaping () -> Parser<B>) -> Parser<(A, B)> {
        return map2(other) { (a, b) in (a, b) }
    }

    public static func <**> <B>(lhs: Parser<A>, rhs: @autoclosure @escaping () -> Parser<B>) -> Parser<(A, B)> {
        return lhs.product(rhs)
    }

    public static func *> <B>(lhs: Parser<A>, rhs: @autoclosure @escaping () -> Parser<B>) -> Parser<B> {
        return lhs.product(rhs).map { $0.1 }
    }

    public static func <* <B>(lhs: Parser<A>, rhs: @autoclosure @escaping () -> Parser<B>) -> Parser<A> {
        return lhs.product(rhs).map { $0.0 }
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

    public func manyOrZero() -> Parser<[A]> {
        return map2(self.manyOrZero(), Array.cons) <|> Parser<[A]>.success([])
    }

    public func many() -> Parser<[A]> {
        return manyOrZero().flatMap { result in
            if result.isEmpty {
                return Parser<[A]>.failure(.error("no elements"))
            } else {
                return Parser<[A]>.success(result)
            }
        }
    }
}

// MARK: - skip

public extension Parser {
    public func skipMany() -> Parser<Void> {
        return many().map { _ in () }
    }
}
