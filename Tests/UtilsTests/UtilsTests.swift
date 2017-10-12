import XCTest
import Utils

class UtilsTests: XCTestCase {
    func testSetExtensions() {
        let set = Set<Int>(arrayLiteral: 1, 2, 3)
        XCTAssertTrue(1 ∈ set)
        XCTAssertFalse(0 ∈ set)
        XCTAssertTrue(set ∋ 1)
        XCTAssertFalse(set ∋ 0)
    }
}
