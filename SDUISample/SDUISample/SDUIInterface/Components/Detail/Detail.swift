import SDUI
import SwiftUI

final class Detail: Component {

    private var name: String = ""
    private var number: Int = 0

    override init(model: ComponentModel) {
        super.init(model: model)
    }

    override func load() {
        if populate() {
            view = DetailView(name: self.name,
                            number: self.number).toAnyView()
            return
        }

        view = Text("DETALHE VAZIO").toAnyView()
    }

    private func populate() -> Bool {
        var populated = false
        let data = model.body.data

        if let name = data[DetailKeys.name.rawValue] {
            self.name = name
            populated = true
        }

        if
            let number = data[DetailKeys.number.rawValue],
            let integer = Int(number)
        {
            self.number = integer
            populated = true
        }

        return populated
    }
}

extension ComponentType {
    static let detail = ComponentType(rawValue: "detail")
}

enum DetailKeys: String {
    case name = "nome"
    case number = "numero"
}
