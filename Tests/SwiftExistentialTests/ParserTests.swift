import XCTest
import Parsec
import Utils
@testable import SwiftExistential

class ParserTests: XCTestCase {
    func testTypeParser() {
        let parser = Parsers.typeParser()

        XCTAssertEqual(try parser.parseOnly("Int"), Type.int)
        XCTAssertEqual(try parser.parseOnly("Int("), Type.int)
        XCTAssertEqual(try parser.parseOnly("Bool"), Type.bool)
        XCTAssertEqual(try parser.parseOnly("Void"), Type.void)
        XCTAssertEqual(try parser.parseOnly("X"), Type.var("X"))
    }

    func testNameParser() {
        let parser = Parsers.nameParser()

        XCTAssertEqual(try parser.parseOnly("hoge"), "hoge")
        XCTAssertEqual(try parser.parseOnly("fuga"), "fuga")
    }

    func testWhiteSpaceParser() {
        let parser = Parsers.whiteSpaces()
        XCTAssertNotNil(try? parser.parseOnly(""))
        XCTAssertNotNil(try parser.parseOnly(" "))
        XCTAssertNotNil(try parser.parseOnly("   "))
        XCTAssertNotNil(try parser.parseOnly(" \n "))
        XCTAssertNotNil(try parser.parseOnly("\t"))
    }

    func testMethodSignatureParser() {
        let parser = Parsers.methodSignatureParser()

        XCTAssertEqual(try parser.parseOnly("func hoge(arg: Int) -> Bool"),
                Term.MethodSignature(methodName: "hoge", argName: "arg", argType: .int, retType: .bool))

        XCTAssertEqual(try parser.parseOnly("func fuga(hoge: User) -> Bool"),
                Term.MethodSignature(methodName: "fuga", argName: "hoge", argType: .var("User"), retType: .bool))
    }

    func testMethodParser() {
        let parser = Parsers.methodParser()

        let sig = Term.MethodSignature(methodName: "hoge", argName: "arg", argType: .int, retType: .bool)
        let body = Term.MethodBody()
        let method = Term.Method(signature: sig, body: body)

        XCTAssertEqual(try parser.parseOnly("func hoge(arg: Int) -> Bool { return arg == 1 }"), method)
    }

    func testProtocolDeclParser() {
        let parser = Parsers.protocolDeclParser()

        let sig = Term.MethodSignature(methodName: "bark", argName: "repeatCount", argType: .int, retType: .void)
        let proto = Term.protocolDecl("Animal", [sig])

        let input =
                "protocol Animal {\n" +
                " func bark(repeatCount: Int) -> Void\n" +
                "}"

        XCTAssertEqual(try parser.parseOnly(input), proto)
    }
}
