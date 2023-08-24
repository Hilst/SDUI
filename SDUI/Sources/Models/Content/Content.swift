import Foundation

public class Content: Codable {
	public var id: String?
	public var type: String?
	public var data: String?
	public var metadata: [String: String]?
	public var child: [Content] = []

	public init() { }

	public required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Keys.self)
		self.id = try container.decodeIfPresent(String.self, forKey: Self.keys[.id]!)
		self.type = try container.decodeIfPresent(String.self, forKey: Self.keys[.type]!)
		self.data = try container.decodeIfPresent(String.self, forKey: Self.keys[.data]!)
		self.metadata = try container.decodeIfPresent([String: String].self, forKey: Self.keys[.metadata]!)
		self.child = try container.decodeIfPresent([Content].self, forKey: Self.keys[.child]!)!
	}
}
