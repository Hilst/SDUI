import SDUI
import SwiftUI

final class Header: Component {

    private var name: String = ""

    override init(model: ComponentModel) {
        super.init(model: model)
    }

    override func load() {
        if populate() {
            view = HeaderView(name: self.name).toAnyView()
            return
        }

        view = Text("HEADER VAZIO").toAnyView()
    }

    private func populate() -> Bool {
        var populated = false
        let data = model.body.data

        if let name = data[HeaderKeys.name.rawValue] {
            self.name = name
            populated = true
        }

        return populated
    }
}

extension ComponentType {
    static let header = ComponentType(rawValue: "header")
}

enum HeaderKeys: String {
    case name = "nome"
}
