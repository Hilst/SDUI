import XCTest
@testable import SDUI

final class StateMachine_Spec: XCTestCase {

	var sut: StateMachine!

	override func setUp() {
		super.setUp()
		sut = StateMachine()
		sut.reset()
	}

	func test_full_flux() {
		XCTAssertEqual(sut.current, .idle)

		let data = Data()
		let content = Content()

		sut.send(event: .initiate)
		XCTAssertEqual(sut.current, .fetching)

		sut.send(event: .load(.success(data)))
		XCTAssertEqual(sut.current, .loading(.success(data)))

		sut.send(event: .render(.success(content)))
		XCTAssertEqual(sut.current, .rendering(.success(content)))

		sut.send(event: .done)
		XCTAssertEqual(sut.current, .awaiting)

		sut.send(event: .action)
		XCTAssertEqual(sut.current, .fetching)
	}
}
