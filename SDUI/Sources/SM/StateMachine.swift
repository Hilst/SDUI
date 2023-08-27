import Foundation
import SDUIModels

final class StateMachine {
	/// STATE MACHINE =============================== ///
	/// 	idle --> initiate (URLRequest) -> fetching	///
	/// 	fetching --> load (Data?) -> loading  			///
	/// 	loading -> render (Content) -> rendering		///
	/// 	rendering -> done -> awaiting								///
	/// 	awaiting -> action (URLRequest) -> fetching ///
	/// ============================================= ///

	public enum State: Equatable {
		case idle, fetching(URLRequest), loading(Data), rendering(Content), awaiting
	}

	public enum Event {
		case initiate(URLRequest), load(Data), render(Content), done, action(URLRequest)
	}

	private(set) var current: State = .idle

	private init() { }
}

extension StateMachine {
	static let instance: StateMachine = StateMachine()
	func reset() {
		current = .idle
	}
}

extension StateMachine {
	func send(event: Event) {
		switch (current, event) {
		case (.idle, .initiate(let req)): current = .fetching(req)
		case (.fetching(_), .load(let data)): current = .loading(data)
		case (.loading(_), .render(let content)): current = .rendering(content)
		case (.rendering, .done): current = .awaiting
		case (.awaiting, .action(let req)): current = .fetching(req)
		default: break
		}
	}
}
