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

    public func flatMap<B>(_ f: @escaping (A) -> Parser<B>) -> Parser<B> {
        return Parser<B> { string in
            let (a, remaining) = self.parse(string)
            return f(a).parse(remaining)
        }
    }
}
