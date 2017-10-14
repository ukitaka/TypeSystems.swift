//
// Created by ukitaka on 2017/10/13.
//

public struct Parser<A> {
    public let parse: Parse<A>

    public init(parse: @escaping Parse<A>) {
        self.parse = parse
    }

    public static func success(_ a: A) -> Parser<A> {
        return Parser<A> { input in
            return .success(a, input)
        }
    }

    public func map<B>(_ f: @escaping (A) -> B) -> Parser<B> {
        return Parser<B> { string in
            return self.parse(string)
                    .map { a, remaining in
                        return (f(a), remaining)
                    }
        }
    }

    public func map2<B, C>(_ other: Parser<B>, _ f: @escaping (A, B) -> C) -> Parser<C> {
        return Parser<C> { string in
            return self.parse(string)
                    .flatMap { a, remaining1 in
                        return other.parse(remaining1).flatMap { b, remaining2 in
                            return ParseResult.success(f(a, b), remaining2)
                        }
                    }
        }
    }

    public func flatMap<B>(_ f: @escaping (A) -> Parser<B>) -> Parser<B> {
        return Parser<B> { string in
            return self.parse(string).flatMap { a, remaining in
                f(a).parse(remaining)
            }
        }
    }
}
