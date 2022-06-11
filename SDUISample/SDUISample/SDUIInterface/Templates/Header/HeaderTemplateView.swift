import SwiftUI
import SDUI

struct HeaderTemplateView: View {

    var components: [Component]

    var body: some View {
        components.first?.render()
    }
}

struct HeaderTemplateView_Previews: PreviewProvider {
    static let model = ComponentModel(type: .header,
                                      data: [HeaderKeys.name.rawValue: "TESTE HOME"])
    static let templateModel = TemplateModel(id: "mock-template",
                                             type: .header,
                                             components: [model])
    static let template = HeaderTemplate(model: templateModel)

    static var previews: some View {
        template.load()
        return template.render()
    }
}
