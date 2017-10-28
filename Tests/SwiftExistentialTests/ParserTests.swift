import XCTest
import Parsec
@testable import SwiftExistential

class ParserTests: XCTestCase {
    func testTypeParser() {
        let parser = Parsers.typeParser()

        XCTAssertEqual(try parser.parseOnly("Int"), Type.int)
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

//    func testMethodSignatureParser() {
//        let parser =
//
//        XCTAssertEqual(try parser.parseOnly("func hoge(arg: Int) -> Bool"),
//                Term.MethodSignature.init(methodName: "hoge", argName: "arg", argType: .int, retType: .bool))
//    }
}
