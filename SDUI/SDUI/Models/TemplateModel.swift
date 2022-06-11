import Foundation

public struct TemplateModel {
    var id: String
    public var type: TemplateType
    public var components: [ComponentModel]

    public init(id: String, type: TemplateType, components: [ComponentModel]) {
        self.id = id
        self.type = type
        self.components = components
    }
}

public struct TemplateType: RawRepresentable {
    public typealias RawValue = String
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension TemplateType: Equatable { }
