import SwiftUI
import SDUI

protocol HeaderDelegate {
    func goBack()
}

struct HeaderView: View {

    var name: String
    var hasBackButton: Bool
    var delegate: HeaderDelegate?

    var body: some View {
        ZStack {
            BackButtonView(condition: hasBackButton) {
                delegate?.goBack()
            }
            Text(name)
                .bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity,
               minHeight: 55,
               alignment: .center)
        .background(Color.purple)
    }
}

private struct BackButtonView: View {

    var condition: Bool
    var action: () -> Void

    init(condition: Bool, action: @escaping () -> ()) {
        self.condition = condition
        self.action = action
    }

    var body: some View {
        if (condition) {
            HStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
                .padding(.leading)

                Spacer()
            }
        } else {
            EmptyView()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {

    static var previews: some View {
        HeaderView(name: "TESTE HOME", hasBackButton: true)
            .previewLayout(.sizeThatFits)
    }
}
