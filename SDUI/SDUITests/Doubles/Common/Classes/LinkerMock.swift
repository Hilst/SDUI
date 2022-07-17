import SwiftUI
import SDUI
import ViewInspector

final class LinkerMock: Linker {
    func initializer(for model: TemplateModel) -> Template {
        TemplateLinked(model: model)
    }

    func initializer(for model: ComponentModel) -> Component {
        ComponentLinked(model: model)
    }
}


// MARK: - TEMPLATE LINKED IN MOCK

final class TemplateLinked: Template {
    override func buildView() -> AnyView {
        _ = super.buildView()
        return TestableView().toAnyView()
    }
}

extension TemplateType {
    static let test = TemplateType(rawValue: "test")
}

// MARK: - COMPONENT LINKED IN MOCK

final class ComponentLinked: Component { }

extension ComponentType {
    static let test = ComponentType(rawValue: "test")
}

// MARK: - TESTABLE VIEW

struct TestableView: View {
    var body: some View {
        Text("#test")
    }
}


// MARK: - INSPECTABLE CONFORMS
extension TestableView: Inspectable { }
extension EmptyView: Inspectable { }
