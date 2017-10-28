//
// Created by ukitaka on 2017/10/28.
//

import Parsec
import Utils

public extension Parsers {
    typealias P = Parsec.Parser
    typealias ProtocolDecl = Term

    static func nameParser() -> P<Name> {
        return Parsers.alphabets()
    }

    static func typeParser() -> P<Type> {
        return (Parsers.string("Int") <^> const(Type.int))
                <|> (Parsers.string("Void") <^> const(Type.void))
                <|> (Parsers.string("Bool") <^> const(Type.bool))
                <|> (self.nameParser() <^> Type.var)
    }

    static func methodSignatureParser() -> P<Term.MethodSignature> {
        return Parsers.string("func")
                *> Parsers.whiteSpaces()
                *> self.nameParser()
                <* Parsers.whiteSpaces()
                <* Parsers.string("(")
                <* Parsers.whiteSpaces()
                <**> self.nameParser()
                <* Parsers.whiteSpaces()
                <* Parsers.string(":")
                <* Parsers.whiteSpaces()
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

    static func methodBodyParser() -> P<Term.MethodBody> {
        return Parsers.skipUntil("}") <^> const(Term.MethodBody()) //TODO
    }

    static func methodParser() -> P<Term.Method> {
        return methodSignatureParser() <**> self.methodBodyParser() <^> Term.Method.init
    }

    static func protocolDeclParser() -> P<ProtocolDecl> {
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
