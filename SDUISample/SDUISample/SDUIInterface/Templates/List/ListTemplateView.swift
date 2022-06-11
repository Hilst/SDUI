import SwiftUI
import SDUI

struct ListTemplateView: View {

    var components: [Component]

    var body: some View {
        List(components, id: \.id) { component in
            component.render()
        }
    }
}

struct ListTemplateView_Previews: PreviewProvider {
    static let data1 = [
        CardKeys.name.rawValue: "TESTE CARD",
        CardKeys.number.rawValue: "1"
    ]
    static let model1 = ComponentModel(type: .card, data: data1)
    static let data2 = [
        CardKeys.name.rawValue: "TESTE CARD",
        CardKeys.number.rawValue: "2"
    ]
    static let model2 = ComponentModel(type: .card, data: data2)
    static let data3 = [
        CardKeys.name.rawValue: "TESTE CARD",
        CardKeys.number.rawValue: "3"
    ]
    static let model3 = ComponentModel(type: .card, data: data3)

    static let templateModel = TemplateModel(id: "mock-template",
                                             type: .list,
                                             components: [model1,model2,model3])
    static let template = ListTemplate(model: templateModel)

    static var previews: some View {
        template.render()
    }

}
