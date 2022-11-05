import SDUI
import SwiftUI

final class Card: Component {

    private var name: String = ""
    private var number: Int = 0
    private var detailRoute: String = ""

    override init(model: ComponentModel) {
        super.init(model: model)
    }

    override func load() {
        if populate() {
            var cardView = CardView(name: self.name,
                            number: self.number,
                            detailRoute: self.detailRoute)
            cardView.delegate = self
            view = cardView.toAnyView()
            return
        }

        view = Text("CARD VAZIO").toAnyView()
    }

    private func populate() -> Bool {
        var populated: [Bool] = Array(repeating: false, count: 3)
        let data = model.body.data

        if let name = data[CardKeys.name.rawValue] {
            self.name = name
            populated[0] = true
        }

        if
            let number = data[CardKeys.number.rawValue],
            let integer = Int(number)
        {
            self.number = integer
            populated[1] = true
        }

        if let name = data[CardKeys.detailRoute.rawValue] {
            self.detailRoute = name
            populated[2] = true
        }

        return populated.reduce(true) { $0 && $1 }
    }
}

extension Card: CardDelegate {
    func goto(detail: String) {
        self.viewModel?.goto(route: Route(rawValue: detail))
    }
}

extension ComponentType {
    static let card = ComponentType(rawValue: "card")
}

enum CardKeys: String {
    case name = "nome"
    case number = "numero"
    case detailRoute = "detailRoute"
}
