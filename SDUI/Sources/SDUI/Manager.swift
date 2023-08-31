import Foundation

public class Manager<T> {
	private(set) var rendered: T?
	private var baseErrorRendered: T?
	var renderer: Renderer<T>?

	weak var client: Client?
	weak var mapper: Mapper?
	private(set) var sm: StateMachine = StateMachine()
}

extension Manager {
	func reset() {
		sm.reset()
		sm.binder = self
	}
	func update(error: T) {
		self.baseErrorRendered = error
	}
	func start() {
		sm.send(event: .initiate)
	}
}

extension Manager: StateBinder {
	func bind(state: StateMachine.State) {
		switch state {
		case .idle: return
		case .fetching: self.performFetch()
		case .loading(let data): self.performLoad(data)
		case .rendering(let content): self.performRender(content)
		case .awaiting: return
		}
	}
}

extension Manager {
	private func performFetch() {
		self.client?.request(complete: { result in
			self.sm.send(event: .load(result))
		})
	}

	private func performLoad(_ fR: StateMachine.FetchingResult) {
		switch fR {
		case .success(let data):
			guard let mapper = self.mapper else {
				sm.send(event: .render(.failure(NSError(domain: "NO MAPPER", code: -1))))
				return
			}
			let mR = mapper.getContent(from: data)
			self.sm.send(event: .render(mR))
		case .failure(let e):
			self.sm.send(event: .render(.failure(e)))
		}
	}

	private func performRender(_ lR: StateMachine.LoadingResult) {
		switch lR {
		case .success(let content):
			self.rendered = self.renderer?(content) ?? baseErrorRendered
		case .failure(let e):
			print(e)
			self.rendered = self.baseErrorRendered
		}
	}
}
