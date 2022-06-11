import XCTest
@testable import SDUI

class ArrayTest: XCTestCase {

    var sut: [Int]!

    override func setUp() {
        sut = [1, 2, 3]
    }

    override func tearDown() {
        sut = nil
    }

    func test_insert_repetition() {
        let startCondition = sut.self
        sut.insertWithoutRepetition(1)
        XCTAssertEqual(sut, startCondition)
    }

    func test_insert_no_repetition() {
        var startCondition = sut.self
        startCondition?.append(4)

        sut.insertWithoutRepetition(4)
        print(startCondition ?? "")
        print(sut ?? "")
        XCTAssertEqual(sut, startCondition)

    }

    func test_insert_empty() {
        sut = []
        sut.insertWithoutRepetition(1)
        XCTAssertEqual(sut.first, 1)
    }
}
