import Foundation

public struct ComponentModel {
    var id: String
    public var type: ComponentType
    public var body: BodyModel

    public init(id: String, type: ComponentType, body: BodyModel) {
        self.id = id
        self.type = type
        self.body = body
    }
}

public struct ComponentType: RawRepresentable {
    public typealias RawValue = String
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension ComponentType: Equatable { }
