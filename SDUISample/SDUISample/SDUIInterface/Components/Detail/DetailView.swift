import SwiftUI
import SDUI

struct DetailView: View {

    var name: String
    var number: Int

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(name)
                    .font(.title2)
                    .padding(.bottom, 0.5)
                Text("\(number)")
                    .font(.title3)
            }
            .frame(maxWidth: geometry.size.width,
                   minHeight: geometry.size.height,
                   alignment: .center)
            .background(color())
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding()
        }
    }
}

extension DetailView {
    func color() -> Color {
        switch number % 3 {
        case 1:
            return .yellow
        case 2:
            return .green
        case 0:
            return .cyan
        default:
            return .white
        }
    }
}

struct DetailView_Previews: PreviewProvider {

    static var previews: some View {
        DetailView(name: "TEST CARD", number: 1)
            .previewLayout(.device)
    }
}

