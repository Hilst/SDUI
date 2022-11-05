import SwiftUI
import SDUI

@main
struct SDUISampleApp: App {

    static private let provider = Provider()
    static private let linker = SampleLinker()
    static let viewModel = SDUIViewModel(initalRoute: .init(rawValue: "um-detail"),
                                         provider: provider,
                                         linker: linker)

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SDUISampleApp.viewModel)
        }
    }
}
