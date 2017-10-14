//
// Created by ukitaka on 2017/10/14.
//

// MARK: - or

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

// MARK: - many

public extension Parser {
    public func listOf(_ n: UInt) -> Parser<[A]> {
        if n == 0 {
            return Parser<[A]>.success([])
        } else {
            return self.map2(self.listOf(n - 1)) { (a, list) in
                var list = list
                list.insert(a, at: 0)
                return list
            }
        }
    }
}
