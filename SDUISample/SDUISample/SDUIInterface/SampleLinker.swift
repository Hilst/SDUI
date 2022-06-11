import Foundation
import SDUI
import SwiftUI

final class SampleLinker: Linker {

    func initializer(for model: TemplateModel) -> Template {
        switch model.type {
        case .header:
            return HeaderTemplate(model: model)
        case .list:
            return ListTemplate(model: model)
        default:
            return HeaderTemplate(model: model)
        }
    }

    func initializer(for model: ComponentModel) -> Component {
        switch model.type {
        case .card:
            return Card(model: model)
        case .header:
            return Header(model: model)
        default:
            return Card(model: model)
        }
    }

}
