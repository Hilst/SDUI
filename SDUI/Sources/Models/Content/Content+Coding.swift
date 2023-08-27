import Foundation

extension Content {
	struct Keys: CodingKey {
		public var stringValue: String
		public init?(stringValue: String) {
			self.stringValue = stringValue
			self.intValue = nil
		}
		public var intValue: Int?
		public init?(intValue: Int) {
			fatalError("NOT SUPPORTED")
		}
	}
	public enum Coding: Int, CaseIterable {
		case id
		case type
		case data
		case metadata
		case child
	}
}

extension Content {
	private(set) static var keys: [Coding: Keys] = [
		.id: .init(stringValue: "id")!,
		.type: .init(stringValue: "type")!,
		.data: .init(stringValue: "data")!,
		.metadata: .init(stringValue: "metadata")!,
		.child: .init(stringValue: "child")!
	]

	public static func setCodingKeys(newKeys input: [Coding: String]) {
		input.forEach { (key, value) in
			Self.keys[key] = .init(stringValue: value)!
		}
	}
}
