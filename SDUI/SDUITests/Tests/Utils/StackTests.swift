import XCTest
@testable import SDUI

class StackTests: XCTestCase {

    var sut: Stack<Int>!

    override func setUp() {
        sut = Stack<Int>()
        sut.push(0)
        // 0
    }

    override func tearDown() {
        sut = nil
    }

    func test_push() {
        // 0

        sut.push(1)
        // 0 1

        XCTAssertEqual(sut.peek(), 1)
        XCTAssertEqual(sut.size, 2)
    }

    func test_peek() {
        // 0

        XCTAssertEqual(sut.peek(), 0)
        XCTAssertEqual(sut.size, 1)
    }

    func test_peek_when_empty() {
        // 0

        _ = sut.pop()
        // --

        XCTAssertNil(sut.peek())
        XCTAssertEqual(sut.size, 0)
    }

    func test_pop() {
        // 0

        sut.push(1)
        // 0 1

        let out = sut.pop()
        // 0
        XCTAssertEqual(out, 1)
        XCTAssertEqual(sut.peek(), 0)
        XCTAssertEqual(sut.size, 1)
    }

    func test_pop_when_empty() {
        // 0

        _ = sut.pop()
        // --

        let out = sut.pop()
        XCTAssertNil(out)
    }
}
