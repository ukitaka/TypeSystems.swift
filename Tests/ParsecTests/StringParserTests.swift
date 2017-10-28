//
// Created by Yuki Takahashi on 2017/10/28.
//

import XCTest
import Parsec

class StringParserTests: XCTestCase {
    func testParseAlphabet() {
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

    func testParseAlphabets() {
        let parser = Parsers.alphabets()
        XCTAssertEqual(try parser.parseOnly("a"), "a")
        XCTAssertEqual(try parser.parseOnly("abc efg"), "abc")
        XCTAssertEqual(try parser.parseOnly("AbC E"), "AbC")
        XCTAssertNil(try? parser.parseOnly(""))
        XCTAssertNil(try? parser.parseOnly(" "))
        XCTAssertNil(try? parser.parseOnly("\n"))
        XCTAssertNil(try? parser.parseOnly("\t"))
        XCTAssertNil(try? parser.parseOnly("あいうえお"))
    }
}
