import XCTest
@testable import AlgorithmW

class AlgorithmWTests: XCTestCase {
    func testSample() {
//        XCTAssertEqual(AlgorithmW.w(.empty(), .literal(.int(1))).1.type, .int)
//        XCTAssertEqual(AlgorithmW.w(.empty(), .literal(.bool(true))).1.type, .bool)
//
//        let tru = Exp.literal(.bool(true))
        let one = Exp.literal(.int(1))
//        let two = Exp.literal(.int(2))
//        XCTAssertEqual(AlgorithmW.w(.empty(), .if(tru, one, two)).1.type, .int)

//        let prefix = TypedPrefix(members: [TypedPrefix.TypedMember.let("id", .freshVar())])
//        XCTAssertTrue(prefix.isActive(member: .let("id")))

        let id = Exp.abs("x", .var("x"))
        let polyId = Exp.let("id", id, .app(.app(.var("id"), .var("id")), .app(.var("id"), one)))
        print(polyId)
        let result = AlgorithmW.w(.empty(), polyId)
        print(result.1.type)
        print(result.0)
//        XCTAssertEqual(AlgorithmW.w(.empty(), polyId).1.type, .int)
    }
}
