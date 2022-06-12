import SwiftUI
import SDUI

struct ErrorView: View {

    @ObservedObject var viewModel: SDUIViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("Error")
            Spacer()
            Button("TO LOADING", action: {
                viewModel.changeState(with: .retry)
            })
        }
    }
}

struct ErrorView_Previews: PreviewProvider {

    static let provider = Provider()
    static let viewModel = SDUIViewModel(initalRoute: .init(rawValue: "lista"),
                                         provider: provider,
                                         linker: SampleLinker())

    static var previews: some View {
        ErrorView(viewModel: viewModel)
    }
}
