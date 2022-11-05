import SDUI
import SwiftUI

final class HeaderTemplate: Template {

    override func buildView() -> AnyView {
        ZStack(alignment: .top) {
            components.first?.view ?? EmptyView().toAnyView()
        }.toAnyView()
    }
}

extension TemplateType {
    static let header = TemplateType(rawValue: "header")
}
