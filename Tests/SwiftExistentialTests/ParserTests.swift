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
}
