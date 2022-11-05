import SwiftUI
import SDUI

struct HeaderView: View {

    var name: String
    var hasBackButton: Bool

    var body: some View {
        ZStack {
            BackButtonView(condition: hasBackButton)
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

    init(condition: Bool) { self.condition = condition }

    var body: some View {
        if (condition) {
            HStack {
                Button {
                    print("back button pressed")
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
