//
// Created by ukitaka on 2017/10/28.
//

import Parsec

public struct Parser {
    typealias P = Parsec.Parser
    typealias ProtocolDecl = Term

    func protocolDeclParser(_ input: String) -> P<ProtocolDecl> {
        fatalError()
//        return Parsers.string("protocol")
//            <* Parsers.whiteSpaces()
//
    }
}

