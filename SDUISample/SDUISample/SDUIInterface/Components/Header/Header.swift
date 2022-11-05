import SDUI
import SwiftUI

final class Header: Component {

    private var name: String = ""
    private var hasBackButton: Bool = true

    override init(model: ComponentModel) {
        super.init(model: model)
    }

    override func load() {
        if populate() {
            var headerView = HeaderView(name: self.name,
                              hasBackButton: self.hasBackButton)
            headerView.delegate = self
            view = headerView.toAnyView()
            return
        }

        view = Text("HEADER VAZIO").toAnyView()
    }

    private func populate() -> Bool {
        var populated = Array(repeating: false, count: 2)
        let data = model.body.data

        if let name = data[HeaderKeys.name.rawValue] {
            self.name = name
            populated[0] = true
        }
        if
            let hasBackButton = data[HeaderKeys.hasBackButton.rawValue],
            let boolean = Bool(hasBackButton)
        {
            self.hasBackButton = boolean
            populated[1] = true
        }

        return populated.reduce(true) { $0 && $1 }
    }
}

extension Header: HeaderDelegate {
    func goBack() {
        self.viewModel?.goBack()
    }
}

extension ComponentType {
    static let header = ComponentType(rawValue: "header")
}

enum HeaderKeys: String {
    case name = "nome"
    case hasBackButton = "hasBackButton"
}
