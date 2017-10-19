//
// Created by ukitaka on 2017/10/14.
//

import Parsec

public struct Parser {
    public func parse(_ input: String) -> ParseResult<Exp> {
        return .failure(.error("not implemented yet"))
    }
}

// MARK: - internals

extension Parser {
    typealias P<A> = Parsec.Parser<A>

    func parseIntLiteral(_ input: String) -> P<Exp> {
        return Parsers.integer().map(Literal.int).map(Exp.literal)
    }

    func parseBoolLiteral(_ input: String) -> P<Exp> {
        return Parsers.bool().map(Literal.bool).map(Exp.literal)
    }
}
