import XCTest
import Parsec

class IntegerParserTests: XCTestCase {
    func testParseIntegers() {
        let parser = Parsers.integer()
        XCTAssertEqual(try parser.parseOnly("0"), 1)
        XCTAssertEqual(try parser.parseOnly("1"), 1)
        XCTAssertEqual(try parser.parseOnly("9"), 9)
        XCTAssertEqual(try parser.parseOnly("10"), 10)
        XCTAssertEqual(try parser.parseOnly("123"), 123)
    }
}
