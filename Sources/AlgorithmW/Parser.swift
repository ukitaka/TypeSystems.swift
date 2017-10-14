//
// Created by ukitaka on 2017/10/14.
//

import Parsec

public struct Parser {
    public func parse(_ input: String) -> ParseResult<Term> {
        return .failure(.error("not implemented yet"))
    }
}

// MARK: - internals

extension Parser {
    typealias P<A> = Parsec.Parser<A>

    func parseIntLiteral(_ input: String) -> P<Term> {
        return Parsers.integer().map(Literal.int).map(Term.literal)
    }
}
