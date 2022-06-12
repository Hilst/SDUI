import Combine

public final class SDUIStateMachine {
    public enum State {
        case start, fetch, load, present, error
    }
    
    public enum Event {
        case initiate  // start   -> serve
        case loadData  // fetch   -> load
        case badData   // fetch   -> error
        case success   // load    -> present
        case failure   // load    -> error
        case react     // present -> fetch
        case retry     // error   -> fetch
    }

    private(set) var state: State {
        didSet { stateSubject.send(self.state) }
    }

    private let stateSubject: PassthroughSubject<State, Never>
    public let statePublisher: AnyPublisher<State, Never>

    public init(initialState: State) {
        self.state = initialState
        self.stateSubject = PassthroughSubject<State, Never>()
        self.statePublisher = stateSubject.eraseToAnyPublisher()
    }

    public func tryEvent(_ event: Event) {
        if let state = nextState(for: event) {
            self.state = state
        }
    }

    private func nextState(for event: Event) -> State? {
        switch state {
        case .start:
            switch event {
            case .initiate: return .fetch
            default: return nil
            }
        case .fetch:
            switch event {
            case .loadData: return .load
            case .badData: return .error
            default: return nil
            }
        case .load:
            switch event {
            case .success: return .present
            case .failure: return .error
            default: return nil
            }
        case .present:
            switch event {
            case .react: return .fetch
            default: return nil
            }
        case .error:
            switch event {
            case .retry: return .fetch
            default: return nil
            }
        }
    }
}
