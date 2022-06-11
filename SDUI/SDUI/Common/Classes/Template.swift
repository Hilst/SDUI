import SwiftUI

open class Template {
    public let id = UUID()

    private let model: TemplateModel
    public var components: [Component] = []

    public weak var linker: Linker?
    public weak var viewModel: SDUIViewModel?
    public var view: AnyView!

    public init(model: TemplateModel) {
        self.model = model
    }

    open func load() {
        model.components.forEach { componentModel in
            guard let linker = linker else { return }
            let component = linker.initializer(for: componentModel)
            component.viewModel = viewModel
            components.insertWithoutRepetition(component)
        }

        components.forEach({ $0.load() })

        view = buildView()
    }

    @ViewBuilder
    public func render() -> some View {
        if view == nil {
            EmptyView()
        } else {
            self.view
        }
    }

    open func buildView() -> AnyView {
        EmptyView().toAnyView()
    }
}

extension Template: Equatable {
    public static func == (lhs: Template, rhs: Template) -> Bool {
        lhs.model.id == rhs.model.id
    }
}
