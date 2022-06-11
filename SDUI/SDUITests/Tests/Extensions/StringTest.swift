import XCTest
@testable import SDUI

class StringTest: XCTestCase {

    var sut: String!

    override func setUp() {
        sut = "abcd++++/// **123 efgh ___ 456---ijkl"
    }

    override func tearDown() {
        sut = nil
    }

    func test_regex() {
        let out = sut.replace(pattern: "[^[:alnum:]]+", with: "-")
        XCTAssertEqual(out, "abcd-123-efgh-456-ijkl")
    }

    func test_regex_error() {
        let out = sut.replace(pattern: "", with: "-")
        XCTAssertEqual(out, sut)
    }
}
