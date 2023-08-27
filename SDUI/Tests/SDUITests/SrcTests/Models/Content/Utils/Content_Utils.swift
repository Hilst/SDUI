import Foundation
import SDUIModels

struct Content_Utils {
	// MARK: - FILES
	private static let FILES: [String: String] = [
		"test_decoding": "sdui_content_test_decoding",
		"test_decoding_new_keys": "sdui_content_test_decoding_new_keys"
	]


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
