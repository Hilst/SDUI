import SDUI
import SwiftUI

final class DetailTemplate: Template {

    override func buildView() -> AnyView {
        components.first?.view ?? EmptyView().toAnyView()
    }
}

extension TemplateType {
    static let detail = TemplateType(rawValue: "detail")
}
