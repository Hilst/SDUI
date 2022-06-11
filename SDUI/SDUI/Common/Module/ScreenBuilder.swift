import Foundation

final class ScreenBuilder {
    // MARK: - PROPERTIES

    private var screen: ScreenModel?

    private var templates: [TemplateModel] = []
    private var components: [ComponentModel] = []
    private var bodies: [BodyModel] = []

    private var screenCoder: ScreenCoder?

    // MARK: - INITIALIZATION

    init(data: Data) {
        self.screenCoder = ScreenBuilder.decodeScreen(from: data)
    }

    private static func decodeScreen(from data: Data) -> ScreenCoder? {
        try? JSONDecoder().decode(ScreenCoder.self, from: data)
    }

    // MARK: - PUBLIC GETTER

    public func getScreen() -> ScreenModel {
        var screen: ScreenModel! = self.screen
        if screen == nil {
            buildScreen()
            screen = self.screen
        }
        return screen
    }

    // MARK: - BUILDERS

    private func buildScreen() {
        // POPULATE BODIES
        let bodies: [BodyModel] = buildBodies()
        self.bodies = bodies

        // POPULATE COMPONENTS
        let components: [ComponentModel] = buildComponents(with: self.bodies)
        self.components = components

        // POPULATES TEMPLATES
        let templates: [TemplateModel] = buildTemplates(with: self.components)
        self.templates = templates

        // BUILD SCREEN
        self.screen = ScreenModel(screenName: screenCoder?.screenName ?? "",
                                  templates: self.templates)
    }

    private func buildBodies() -> [BodyModel] {
        guard let screenCoder = screenCoder else { return [] }
        let bodiesCoders = screenCoder.bodies

        var bodies: [BodyModel] = []
        bodiesCoders.forEach { coder in

            let model = BodyModel(id: coder.id,
                                  data: coder.body)
            bodies.append(model)
        }

        return bodies
    }

    private func buildComponents(with bodies: [BodyModel]) -> [ComponentModel] {
        guard let screenCoder = screenCoder else { return [] }
        let componentsCoder = screenCoder.components

        var components: [ComponentModel] = []
        componentsCoder.forEach { coder in

            if let bodyModel = bodies.first(where: { $0.id == coder.bodyId }) {

                let model = ComponentModel(id: coder.id,
                                           type: ComponentType(rawValue: coder.type),
                                           body: bodyModel)
                components.append(model)
            }
        }

        return components
    }

    private func buildTemplates(with components: [ComponentModel]) -> [TemplateModel] {
        guard let screenCoder = screenCoder else { return [] }
        let templatesCoder = screenCoder.templates

        var template: [TemplateModel] = []
        templatesCoder.forEach { coder in

            var componentsInTemplate: [ComponentModel] = []
            coder.componentsId.forEach { componentId in

                if let componentModel = components.first(where: { $0.id == componentId }) {
                    componentsInTemplate.append(componentModel)
                }
            }

            let model = TemplateModel(id: coder.id,
                                      type: TemplateType(rawValue: coder.type),
                                      components: componentsInTemplate)
            template.append(model)
        }

        return template
    }
}
