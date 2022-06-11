import XCTest
@testable import SDUI

class RouterTest: XCTestCase {

    var sut: Router!

    override func setUp() {
        sut = Router(initialRoute: .ARoute)
    }

    override func tearDown() {
        sut = nil
    }

    func test_go_to() {
        XCTAssertEqual(sut.current(), .ARoute)
        sut.goto(route: .BRoute)
        XCTAssertEqual(sut.current(), .BRoute)
    }

    func test_go_back() {
        sut.goto(route: .BRoute)
        XCTAssertEqual(sut.current(), .BRoute)
        sut.goBack()
        XCTAssertEqual(sut.current(), .ARoute)
    }

    func test_go_back_when_initial() {
        sut.goBack()
        XCTAssertEqual(sut.current(), .ARoute)
    }

    func test_current() {
        XCTAssertEqual(sut.current(), .ARoute)
        sut.goto(route: .BRoute)
        XCTAssertEqual(sut.current(), .BRoute)
        sut.goBack()
        XCTAssertEqual(sut.current(), .ARoute)
        sut.goBack()
        XCTAssertEqual(sut.current(), .ARoute)
    }

    func test_full_trace() {
        sut.goto(route: .ARoute)
        XCTAssertEqual(sut.fullTrace(), "a.a")
        sut.goto(route: .BRoute)
        XCTAssertEqual(sut.fullTrace(), "a.a.b")
        sut.goto(route: .ARoute)
        XCTAssertEqual(sut.fullTrace(), "a.a.b.a")
        sut.goto(route: .ARoute)
        XCTAssertEqual(sut.fullTrace(), "a.a.b.a.a")
        sut.goto(route: .BRoute)
        XCTAssertEqual(sut.fullTrace(), "a.a.b.a.a.b")
        sut.goBack()
        XCTAssertEqual(sut.fullTrace(), "a.a.b.a.a")
    }
}

fileprivate extension Route {
    static let ARoute = Route(rawValue: "A")
    static let BRoute = Route(rawValue: "B")
}
