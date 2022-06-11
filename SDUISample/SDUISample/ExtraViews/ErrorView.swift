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
                viewModel.changeState(with: .loadData)
            })
        }
    }
}

struct ErrorView_Previews: PreviewProvider {

    static let provider = Provider()
    static let sdui = SDUIInterface(provider: provider, initialRoute: .init(rawValue: "lista"), linker: SampleLinker())

    static var previews: some View {
        ErrorView(viewModel: sdui.viewModel())
    }
}
