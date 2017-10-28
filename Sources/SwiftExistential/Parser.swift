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

    func methodSignatureParser() -> P<Term.MethodSignature> {
        return Parsers.string("func")
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
                <^> flatten
                <^> Term.MethodSignature.init
    }

    func methodBodyParser() -> P<Term.MethodBody> {
        return Parsers.skipUntil("}").map { _ in Term.MethodBody() } //TODO
    }

    func methodParser() -> P<Term.Method> {
        return methodSignatureParser() <**> self.methodBodyParser() <^> Term.Method.init
    }

    func protocolDeclParser() -> P<ProtocolDecl> {
        return Parsers.string("protocol")
                *> Parsers.whiteSpaces()
                *> self.nameParser()
                <* Parsers.whiteSpaces()
                <* Parsers.string("{")
                <* Parsers.whiteSpaces()
                <**> self.methodSignatureParser().manyOrZero()
                <* Parsers.string("}")
                <^> ProtocolDecl.protocolDecl
    }
}
