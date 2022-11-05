import SwiftUI
import SDUI

struct ContentView: View {

    @ObservedObject var viewModel: SDUIViewModel

    var body: some View {
        VStack(spacing: 0) {
            self.content
            Spacer(minLength: 0)
        }
    }

    private var content: some View {
        switch viewModel.state {
        case .error: return ErrorView(viewModel: viewModel).toAnyView()
        case .present: return self.active.toAnyView()
        default: return LoadingView(viewModel: viewModel).toAnyView()
        }
    }

    private var active: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.templates, id: \.id) { template in
                template.render()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static let provider = Provider()
    static let viewModel = SDUIViewModel(initalRoute: .init(rawValue: "lista"),
                                         provider: provider,
                                         linker: SampleLinker())

    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
