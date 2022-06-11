import SwiftUI

public protocol Linker: AnyObject {
    func initializer(for model: TemplateModel) -> Template
    func initializer(for model: ComponentModel) -> Component
}
