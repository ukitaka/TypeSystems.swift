//
// Created by Yuki Takahashi on 2017/10/14.
//

import XCTest
import Parsec

class BoolParserTests: XCTestCase {
    func testParseIntegers() {
        let parser = Parsers.bool()
        XCTAssertEqual(try parser.parseOnly("true"), true)
        XCTAssertEqual(try parser.parseOnly("false"), false)
        XCTAssertNil(try? parser.parseOnly(""))
    }
}