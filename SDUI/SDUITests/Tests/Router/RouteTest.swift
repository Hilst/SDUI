import XCTest
@testable import SDUI

class RouteTest: XCTestCase {

    var sut: Route!

    override func setUp() {
        //
    }

    override func tearDown() {
        sut = nil
    }

    func test_initializer_naming() {
        sut = Route(rawValue: "abcd++++/// **123 efgh ___ 456---ijkl")
        let out = sut.rawValue
        XCTAssertEqual(out, "abcd-123-efgh-456-ijkl")
    }
}
