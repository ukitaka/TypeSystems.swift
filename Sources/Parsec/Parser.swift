//
// Created by ukitaka on 2017/10/13.
//

public struct Parser<A> {
    public let parse: Parse<A>

    public init(parse: @escaping Parse<A>) {
        self.parse = parse
    }
}
