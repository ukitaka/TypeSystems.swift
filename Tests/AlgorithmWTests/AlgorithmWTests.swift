import XCTest
@testable import AlgorithmW

class AlgorithmWTests: XCTestCase {
    func testSample() {
        XCTAssertEqual(AlgorithmW.w(.empty(), .literal(.int(1))).1.type, .int)
        XCTAssertEqual(AlgorithmW.w(.empty(), .literal(.bool(true))).1.type, .bool)
    }
}

