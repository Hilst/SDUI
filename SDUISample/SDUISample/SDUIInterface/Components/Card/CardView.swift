import SwiftUI
import SDUI

struct CardView: View {

    var name: String
    var number: Int
    var delegate: CardDelegate?

    var body: some View {
        HStack {
            Text(name)
                .font(.title2)
            Spacer()
            Text("\(number)")
                .font(.title3)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity,
               minHeight: 100,
               alignment: .center)
        .background(color())
        .onTapGesture {
            delegate?.performAction()
        }
    }
}

extension CardView {
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

struct CardView_Previews: PreviewProvider {

    static var previews: some View {
        CardView(name: "TEST CARD", number: 1)
            .previewLayout(.sizeThatFits)
        CardView(name: "TEST CARD", number: 2)
            .previewLayout(.sizeThatFits)
        CardView(name: "TEST CARD", number: 3)
            .previewLayout(.sizeThatFits)
    }
}
