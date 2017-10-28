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

//        let parser = Parsers.string("func")
//                *> Parsers.whiteSpaces()
//                *> Parsers.nameParser()
//                <* Parsers.whiteSpaces()
//                <* Parsers.string("(")
//                <* Parsers.whiteSpaces()
//                <**> Parsers.nameParser()
//                <* Parsers.whiteSpaces()
//                <* Parsers.string(":")
//                <**> Parsers.typeParser()
//                <* Parsers.whiteSpaces()
//                <* Parsers.string(")")
//                <* Parsers.whiteSpaces()
//                <* Parsers.string("->")
//                <* Parsers.whiteSpaces()
//                <**> self.typeParser()
//        let result = try! parser.parseOnly("func hoge(arg: Int) -> Bool")
//        let result = flatten(try! parser.parseOnly("func hoge(arg: Int) -> Bool"))
//        XCTAssertEqual(result.0, "hoge")
//        XCTAssertEqual(result.1, "arg")
//        XCTAssertEqual(result.2, Type.int)



        XCTAssertEqual(try parser.parseOnly("func hoge(arg: Int) -> Bool"),
                Term.MethodSignature(methodName: "hoge", argName: "arg", argType: .int, retType: .bool))
    }
}
