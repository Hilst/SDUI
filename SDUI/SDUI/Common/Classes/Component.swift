import SwiftUI

open class Component {
    public let id = UUID()

    public let model: ComponentModel

    weak var viewModel: SDUIViewModel?
    public var view: AnyView!

    public init(model: ComponentModel) {
        self.model = model
    }

    open func load() {
        // TO BE OVERRIDEN
    }
}

extension Component: Equatable {
    public static func == (lhs: Component, rhs: Component) -> Bool {
        lhs.model.id == rhs.model.id
    }
}
