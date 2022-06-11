import SwiftUI
import SDUI

struct LoadingView: View {

    @ObservedObject var viewModel: SDUIViewModel

    var body: some View {
        Text("Loading")
    }
}

struct LoadingView_Previews: PreviewProvider {

    static let provider = Provider()
    static let sdui = SDUIInterface(provider: provider, initialRoute: .init(rawValue: "lista"), linker: SampleLinker())

    static var previews: some View {
        LoadingView(viewModel: sdui.viewModel())
    }
}
