//
// Created by ukitaka on 2017/10/13.
//

public struct Parser<A> {
    public let parse: Parse<A>

    public init(parse: @escaping Parse<A>) {
        self.parse = parse
    }

    public func parseOnly(_ input: String) throws -> A {
        switch parse(input) {
        case let .success(a, _):
            return a
        case let .failure(error):
            throw error
        }
    }

    // for testing

    func forceParse(_ input: String) -> A {
        switch parse(input) {
        case let .success(a, _):
            return a
        case let .failure(error):
            fatalError(error.description)
        }
    }

    public static func success(_ a: A) -> Parser<A> {
        return Parser<A> { input in
            return .success(a, input)
        }
    }

    public static func failure(_ error: ParseError) -> Parser<A> {
        return Parser<A> { _ in
            return .failure(error)
        }
    }

    public func map<B>(_ f: @escaping (A) -> B) -> Parser<B> {
        return Parser<B> { input in
            return self.parse(input)
                    .map { a, remaining in
                        return (f(a), remaining)
                    }
        }
    }

    public static func <^> <B>(_ parser: Parser<A>, _ f: @escaping (A) -> B) -> Parser<B> {
        return parser.map(f)
    }

    public func discard() -> Parser<Void> {
        return map { _ in }
    }

    public func mapResult<B>(_ f: @escaping (A, String) -> ParseResult<B>) -> Parser<B> {
        return Parser<B> { input in
            switch self.parse(input) {
            case let .success(a, remaining):
                return f(a, remaining)
            case let .failure(error):
                return .failure(error)
            }

        }
    }

    public func map2<B, C>(_ other: @autoclosure @escaping () -> Parser<B>, _ f: @escaping (A, B) -> C) -> Parser<C> {
        return Parser<C> { input in
            return self.parse(input)
                    .flatMap { a, remaining1 in
                        return other().parse(remaining1).flatMap { b, remaining2 in
                            return ParseResult.success(f(a, b), remaining2)
                        }
                    }
        }
    }

    public func flatMap<B>(_ f: @escaping (A) -> Parser<B>) -> Parser<B> {
        return Parser<B> { input in
            return self.parse(input).flatMap { a, remaining in
                f(a).parse(remaining)
            }
        }
    }
}
