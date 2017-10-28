import XCTest
import Parsec
@testable import SwiftExistential

class ParserTests: XCTestCase {
    func testTypeParser() {
        let parser = Parsers.typeParser()

        XCTAssertEqual(try parser.parseOnly("Int"), Type.int)

    }
}
