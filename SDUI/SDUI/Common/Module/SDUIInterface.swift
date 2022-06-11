import Foundation

public final class SDUIInterface {

    private let provider: ProviderProtocol
    private let router: Router
    private let linker: Linker

    public init(provider: ProviderProtocol, initialRoute: Route, linker: Linker) {
        self.provider = provider
        self.router = Router(initialRoute: initialRoute)
        self.linker = linker
    }

    public func viewModel() -> SDUIViewModel {
        return SDUIViewModel(router: router, provider: provider, linker: linker)
    }
}
