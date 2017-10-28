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

    func typeParser() -> P<Type> {
        return (Parsers.string("Int")
                <|> Parsers.string("Void")
                <|> Parsers.string("Bool")
                <|> self.nameParser()).map(Type.var)
    }

    func methodSignatureParser() -> P<Term.Method> {
        let p = Parsers.string("func")
                *> Parsers.whiteSpaces()
                *> self.nameParser()
                <* Parsers.whiteSpaces()
                <* Parsers.string("(")
                <* Parsers.whiteSpaces()
                <* Parsers.string("arg")
                <* Parsers.whiteSpaces()
                <* Parsers.string(":")
                <**> self.typeParser()
                <* Parsers.whiteSpaces()
                <* Parsers.string(")")
                <* Parsers.whiteSpaces()
                <* Parsers.string("->")
                <* Parsers.whiteSpaces()
                <**> self.typeParser()
        return p.map { result in
            let name: String = result.0.0
            let arg: Type = result.0.1
            let ret: Type = result.1
            return Term.Method(name: name, type: .func(arg, ret))
        }
    }

    func protocolDeclParser() -> P<ProtocolDecl> {
        fatalError()
//        return Parsers.string("protocol")
//            <* Parsers.whiteSpaces()
//            *> nameParser()
//            <* Parsers.whiteSpaces()
    }
}

