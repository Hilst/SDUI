import SwiftUI
import SDUI

struct HeaderView: View {

    var name: String

    var body: some View {
        HStack {
            Spacer()
            Text(name)
                .bold()
                .foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity,
               minHeight: 55,
               alignment: .center)
        .background(Color.purple)
    }
}

struct HeaderView_Previews: PreviewProvider {

    static var previews: some View {
        HeaderView(name: "TESTE HOME")
            .previewLayout(.sizeThatFits)
    }
}
