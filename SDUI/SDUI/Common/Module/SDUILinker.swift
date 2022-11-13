import SwiftUI

public protocol SDUILinker: AnyObject {
    func initializer(for model: TemplateModel) -> Template
    func initializer(for model: ComponentModel) -> Component
}
