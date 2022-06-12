import SwiftUI
import Combine

// MARK: - PROPERTIES and INITIALIZER
public final class SDUIViewModel: ObservableObject {

    // MARK: - STATE MACHINE PROP
    private let stateMachine: SDUIStateMachine

    private var stateCancellable: AnyCancellable?

    @Published public private(set) var state: SDUIStateMachine.State {
        willSet { leave(state: state) }
        didSet { enter(state: state) }
    }

    @Published public var templates = [Template]()

    // MARK: - BUSINESS PROP
    private let router: Router
    private let service: Service
    private let linker: Linker
    private let screen: Screen
    private var screenModel: ScreenModel?

    // MARK: - INITIALIZER
    init(router: Router,
         provider: ProviderProtocol,
         linker: Linker,
         stateMachine: SDUIStateMachine = SDUIStateMachine(initialState: .start)) {
        
        self.stateMachine = stateMachine
        self.state = stateMachine.state

        self.router = router
        self.service = Service(provider: provider)
        self.linker = linker

        self.screen = Screen()
        screen.viewModel = self
        screen.linker = linker

        self.stateCancellable = stateMachine.statePublisher.sink { state in
            self.state = state
        }

        stateMachine.tryEvent(.initiate)
    }
}

// MARK: - STATE MACHINE ACTIONS
extension SDUIViewModel {
    private func enter(state: SDUIStateMachine.State) {
        switch state {
        case .fetch:
            let current = router.current()
            screenModel = fetch(route: current)
            send(event: (screenModel == nil ? .badData : .loadData))
            break
        case .load:
            if let model = screenModel {
                screen.load(model: model)
                send(event: (screen.templates.isEmpty ? .failure : .success))
            }
            break
        case .present:
            templates = screen.templates
            break
        default: break
        }
    }

    private func leave(state: SDUIStateMachine.State) {
        switch state {
        case .present:
            templates = []
            break
        default: break
        }
    }

    private func send(event: SDUIStateMachine.Event) {
        self.stateMachine.tryEvent(event)
    }
}

// MARK: - STATE MACHINE INTERFACE
public extension SDUIViewModel {
    func changeState(with event: SDUIStateMachine.Event) {
        self.stateMachine.tryEvent(event)
    }
}

// MARK: - ROUTING
public extension SDUIViewModel {
    func goto(route: Route) {
        router.goto(route: route)
    }

    func goBack() {
        router.goBack()
    }
}

// MARK: - FETCHING
private extension SDUIViewModel {
    private func fetch(route: Route) -> ScreenModel? {
        return service.get(screenName: route.rawValue)
    }
}
