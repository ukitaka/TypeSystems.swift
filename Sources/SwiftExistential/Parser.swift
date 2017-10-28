//
// Created by ukitaka on 2017/10/28.
//

import Parsec

public struct Parser {
    typealias P = Parsec.Parser
    typealias ProtocolDecl = Term

    func nameParser() -> P<Name> {
        return Parsers.alphabets()
    }

    func protocolDeclParser() -> P<ProtocolDecl> {
        fatalError()
//        return Parsers.string("protocol")
//            <* Parsers.whiteSpaces()
//            *> nameParser()
//            <* Parsers.whiteSpaces()
    }
}

