import SDUI
import SwiftUI

final class Card: Component {

    private var name: String = ""
    private var number: Int = 0

    override init(model: ComponentModel) {
        super.init(model: model)
    }

    override func load() {
        if populate() {
            view = CardView(name: self.name,
                            number: self.number).toAnyView()
            return
        }

        view = Text("CARD VAZIO").toAnyView()
    }

    private func populate() -> Bool {
        var populated = false
        let data = model.body.data

        if let name = data[CardKeys.name.rawValue] {
            self.name = name
            populated = true
        }

        if
            let number = data[CardKeys.number.rawValue],
            let integer = Int(number)
        {
            self.number = integer
            populated = true
        }

        return populated
    }
}

extension ComponentType {
    static let card = ComponentType(rawValue: "card")
}

enum CardKeys: String {
    case name = "nome"
    case number = "numero"
}
