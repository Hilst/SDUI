import SDUI
import SwiftUI

final class HeaderTemplate: Template {

    override func buildView() -> AnyView {
        components.first?.view ?? EmptyView().toAnyView()
    }
}

extension TemplateType {
    static let header = TemplateType(rawValue: "header")
}
