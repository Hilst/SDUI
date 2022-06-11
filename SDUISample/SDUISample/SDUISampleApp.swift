import SwiftUI
import SDUI

@main
struct SDUISampleApp: App {

    static private let provider = Provider()
    static private let linker = SampleLinker()
    let sdui = SDUIInterface(provider: SDUISampleApp.provider, initialRoute: .init(rawValue: "lista"), linker: linker)

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: sdui.viewModel())
        }
    }
}
