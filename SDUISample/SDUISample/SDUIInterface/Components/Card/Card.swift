import SDUI
import SwiftUI

final class Card: Component {

    private var name: String = ""
    private var number: Int = 0
    private var actionSignature: String = ""
    private var actionParameter: Any? = nil

    override init(model: ComponentModel) {
        super.init(model: model)
    }

    override func load() {
        if populate() {
            var cardView = CardView(name: self.name,
                            number: self.number)
            cardView.delegate = self
            view = cardView.toAnyView()
            return
        }

        view = Text("CARD VAZIO").toAnyView()
    }

    private func populate() -> Bool {
        var populated: [Bool] = Array(repeating: false, count: CardKeys.allCases.count)
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

        if let signature = data[CardKeys.actionSignature.rawValue] {
            self.actionSignature = signature
            populated[2] = true
        }

        if let parameter = data[CardKeys.actionParameter.rawValue] {
            self.actionParameter = parameter
            populated[3] = true
        }

        return populated.reduce(true) { $0 && $1 }
    }
}

protocol CardDelegate {
    func performAction()
}

extension Card: CardDelegate {
    func performAction() {
        self.viewModel?.performActionFromManager(withSignature: actionSignature, andParameter: actionParameter)
    }
}

extension ComponentType {
    static let card = ComponentType(rawValue: "card")
}

enum CardKeys: String, CaseIterable {
    case name = "nome"
    case number = "numero"
    case actionSignature = "actionSignature"
    case actionParameter = "actionBody"
}
