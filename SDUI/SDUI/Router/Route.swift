import Foundation

// swiftlint:disable private_over_fileprivate
fileprivate let REGEXPATTERN = "[^[:alnum:]]+"

public struct Route: RawRepresentable {
    public typealias RawValue = String
    public var rawValue: String

    public init(rawValue: String) {
        let name = rawValue.lowercased().replace(pattern: REGEXPATTERN, with: "-")
        self.rawValue = name
    }
}

extension Route: Equatable { }
