//
// Created by ukitaka on 2017/10/13.
//

public struct Parser<A> {
    public let parse: Parse<A>

    public init(parse: @escaping Parse<A>) {
        self.parse = parse
    }

    public func map<B>(_ f: @escaping (A) -> B) -> Parser<B> {
        return Parser<B> { string in
            let (a, remaining) = self.parse(string)
            return (f(a), remaining)
        }
    }

    public func map2<B, C>(_ other: Parser<B>, _ f: @escaping (A, B) -> C) -> Parser<C> {
        return Parser<C> { string in
            let (a, remaining1) = self.parse(string)
            let (b, remaining2) = other.parse(remaining1)
            return (f(a, b), remaining2)
        }
    }

    public func flatMap<B>(_ f: @escaping (A) -> Parser<B>) -> Parser<B> {
        return Parser<B> { string in
            let (a, remaining) = self.parse(string)
            return f(a).parse(remaining)
        }
    }
}
