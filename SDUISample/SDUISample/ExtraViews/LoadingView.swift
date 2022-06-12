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
    static let viewModel = SDUIViewModel(initalRoute: .init(rawValue: "lista"),
                                         provider: provider,
                                         linker: SampleLinker())

    static var previews: some View {
        LoadingView(viewModel: viewModel)
    }
}
