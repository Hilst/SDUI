import SwiftUI
import SDUI

final class LinkerMock: Linker {
    func initializer(for model: TemplateModel) -> Template {
        TemplateLinked(model: model)
    }

    func initializer(for model: ComponentModel) -> Component {
        ComponentLinked(model: model)
    }
}

final class TemplateLinked: Template {
    override func buildView() -> AnyView {
        _ = super.buildView()
        return AnyView(Text("test"))
    }
}
extension TemplateType {
    static let test = TemplateType(rawValue: "test")
}

final class ComponentLinked: Component { }
extension ComponentType {
    static let test = ComponentType(rawValue: "test")
}
