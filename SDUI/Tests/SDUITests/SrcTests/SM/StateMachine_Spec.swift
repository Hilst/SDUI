import XCTest
import SDUIModels
@testable import SDUIStateMachine

final class StateMachine_Spec: XCTestCase {
		override func setUp() {
				super.setUp()
				StateMachine.instance.reset()
		}

		func test_full_flux() {
				XCTAssertEqual(StateMachine.instance.current, .idle)

				let req = URLRequest(url: URL(string: "https://example.com")!)
				let data = Data()
				let content = Content()

				StateMachine.instance.send(event: .initiate(req))
				XCTAssertEqual(StateMachine.instance.current, .fetching(req))

				StateMachine.instance.send(event: .load(data))
				XCTAssertEqual(StateMachine.instance.current, .loading(data))

				StateMachine.instance.send(event: .render(content))
				XCTAssertEqual(StateMachine.instance.current, .rendering(content))

				StateMachine.instance.send(event: .done)
				XCTAssertEqual(StateMachine.instance.current, .awaiting)

				StateMachine.instance.send(event: .action(req))
				XCTAssertEqual(StateMachine.instance.current, .fetching(req))
		}
}
