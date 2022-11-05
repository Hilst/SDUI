import SDUI
import SwiftUI

final class ListTemplate: Template {

    override func buildView() -> AnyView {
        List(components, id: \.id) { component in
            component.view
        }
        .listStyle(.sidebar)
        .toAnyView()
    }
}

extension TemplateType {
    static let list = TemplateType(rawValue: "list")
}
