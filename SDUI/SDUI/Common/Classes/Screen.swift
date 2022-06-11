import SwiftUI

public final class Screen {

    public var templates = [Template]()

    weak var viewModel: SDUIViewModel?
    weak var linker: Linker?

    func load(model: ScreenModel) {
        templates = []
        model.templates.forEach { templateModel in
            guard let linker = linker else { return }
            let template = linker.initializer(for: templateModel)
            template.linker = linker
            template.viewModel = viewModel
            templates.insertWithoutRepetition(template)
        }

        templates.forEach { $0.load() }
    }
}
