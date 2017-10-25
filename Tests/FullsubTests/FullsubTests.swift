import XCTest
@testable import Fullsub

class FullsubTests: XCTestCase {
    func testIsSubType() {
        let recordType1 = Type.record([
            "hoge": Type.top,
            "fuga": Type.top
        ])

        let recordType2 = Type.record([
            "hoge": Type.top,
            "fuga": Type.top,
            "piyo": Type.top
        ])

        XCTAssertTrue(Type.top.isSubType(of: .top))
        XCTAssertTrue(recordType2.isSubType(of: recordType1))
        XCTAssertTrue(recordType1.isSubType(of: .top))
        XCTAssertTrue(recordType2.isSubType(of: .top))
    }
}
