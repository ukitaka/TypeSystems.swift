//
// Created by ukitaka on 2017/10/28.
//

import Parsec
import Utils

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
                <**> self.nameParser()
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
            let (methodName, argName, argType, retType) = flatten(result)
            return Term.Method(methodName: methodName, argName: argName, type: .func(argType, retType))
        }
    }

    func protocolDeclParser() -> P<ProtocolDecl> {
        let p = Parsers.string("protocol")
                *> Parsers.whiteSpaces()
                *> self.nameParser()
                <* Parsers.whiteSpaces()
                <* Parsers.string("{")
                <* Parsers.whiteSpaces()
                <**> self.methodSignatureParser().manyOrZero()
                <* Parsers.string("}")

        return p.map { name, methods in
            ProtocolDecl.protocolDecl(name, methods)
        }
    }
}
