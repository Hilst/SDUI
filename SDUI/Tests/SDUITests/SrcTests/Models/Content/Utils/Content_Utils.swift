import Foundation
import SDUI

struct Content_Utils {
	// MARK: - BUILD EXAMPLE
	static func createSDUIContent(_ suffix: String) -> Content {
		let c = Content()
		c.id = "id-\(suffix)"
		c.data = "something"
		c.type = "type-\(suffix)"
		c.metadata = [
			"meta": "meta-\(suffix)",
			"data": suffix.replacingOccurrences(of: "-", with: "")
		]
		c.child = []
		return c
	}
}
