import Foundation

protocol StateBinder: AnyObject {
	func bind(state: StateMachine.State)
}
final class StateMachine {
	/// STATE MACHINE =============================== ///
	/// 	idle --> initiate (URLRequest) -> fetching	///
	/// 	fetching --> load (Data?) -> loading  			///
	/// 	loading -> render (Content) -> rendering		///
	/// 	rendering -> done -> awaiting								///
	/// 	awaiting -> action (URLRequest) -> fetching ///
	/// ============================================= ///

	public typealias FetchingResult = Result<Data, Error>
	typealias	LoadingResult = Result<Content, Error>

	public enum State: Equatable {
		case idle, fetching, loading(FetchingResult), rendering(LoadingResult), awaiting

		public static func == (lhs: StateMachine.State, rhs: StateMachine.State) -> Bool {
			switch (lhs, rhs) {
			case (.idle, .idle): return true
			case (.fetching, .fetching): return true
			case (.awaiting, .awaiting): return true
			case (.loading(let LFR), .loading(let RFR)):
				switch (LFR, RFR) {
				case (.success(let ld), .success(let rd)): return ld == rd
				case (.failure(_), .failure(_)): return true
				default: return false
				}
			case (.rendering(let LLR), .rendering(let RLR)):
				switch (LLR, RLR) {
				case (.success(let ld), .success(let rd)): return ld == rd
				case (.failure(_), .failure(_)): return true
				default: return false
				}
			default: return false
			}
		}
	}

	public enum Event {
		case initiate, load(FetchingResult), render(LoadingResult), done, action
	}

	private(set) var current: State = .idle {
		didSet {
			self.binder?.bind(state: current)
		}
	}
	weak var binder: StateBinder?
}

extension StateMachine {
	func reset() {
		current = .idle
	}
}

extension StateMachine {
	func send(event: Event) {
		switch (current, event) {
		case (.idle, .initiate): current = .fetching
		case (.fetching, .load(let data)): current = .loading(data)
		case (.loading(_), .render(let content)): current = .rendering(content)
		case (.rendering, .done): current = .awaiting
		case (.awaiting, .action): current = .fetching
		default: break
		}
	}
}
