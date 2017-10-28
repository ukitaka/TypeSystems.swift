//
// Created by Yuki Takahashi on 2017/10/28.
//

import XCTest
import Parsec

class StringParserTests: XCTestCase {
    func testParseString() {
        let parser = Parsers.alphabet()
        XCTAssertEqual(try parser.parseOnly("a"), Character("a"))
        XCTAssertEqual(try parser.parseOnly("B"), Character("B"))
        XCTAssertEqual(try parser.parseOnly("abc"), Character("a"))
        XCTAssertNil(try? parser.parseOnly(""))
        XCTAssertNil(try? parser.parseOnly(" "))
        XCTAssertNil(try? parser.parseOnly("\n"))
        XCTAssertNil(try? parser.parseOnly("\t"))
        XCTAssertNil(try? parser.parseOnly("あいうえお"))
    }
}
