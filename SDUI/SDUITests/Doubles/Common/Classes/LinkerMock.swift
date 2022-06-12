import Foundation
import SDUI

final class LinkerMock: Linker {
    func initializer(for model: TemplateModel) -> Template {
        TemplateLinked(model: model)
    }

    func initializer(for model: ComponentModel) -> Component {
        ComponentLinked(model: model)
    }
}

final class TemplateLinked: Template { }
extension TemplateType {
    static let test = ComponentType(rawValue: "test")
}

final class ComponentLinked: Component { }
extension ComponentType {
    static let test = ComponentType(rawValue: "test")
}
