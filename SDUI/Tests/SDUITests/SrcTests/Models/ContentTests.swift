import XCTest
@testable import SDUIModels

final class ContentTests: XCTestCase {

	override func tearDown() {
		Content.setCodingKeys(newKeys: [
			.id: "id",
			.type: "type",
			.data: "data",
			.metadata: "metadata",
			.child: "child"
		])
	}

	func test_decoding() throws {
		let base = example()
		let reader = Reader()
		guard let data = reader.readJson(pathNoExtension: FILES.test_decoding.rawValue)
		else {
			XCTFail("check file \(FILES.test_decoding.rawValue)")
			return
		}
		let out = try? JSONDecoder().decode(Content.self, from: data)
		XCTAssertNotNil(out)
		XCTAssertEqual(base, out)
	}

	func test_decoding_new_keys() throws {
		let base = example()
		let reader = Reader()
		guard let data = reader.readJson(pathNoExtension: FILES.test_decoding_new_keys.rawValue)
		else {
			XCTFail("check file \(FILES.test_decoding.rawValue)")
			return
		}
		Content.setCodingKeys(newKeys: [
			.id: "a"
		])
		let out = try? JSONDecoder().decode(Content.self, from: data)
		XCTAssertNotNil(out)
		XCTAssertEqual(base, out)
	}
}

// MARK: - FILES
enum FILES: String {
	case test_decoding = "sdui_content_test_decoding"
	case test_decoding_new_keys = "sdui_content_test_decoding_new_keys"
}

// MARK: - BUILD EXAMPLE
fileprivate func example() -> Content {
	let root = Node(v: "1", cd: [
		Node(v: "1-1", cd: [
			Node(v: "1-1-1", cd: [])
		]),
		Node(v: "1-2", cd: [])
	])
	return build(fromNode: root)
}
fileprivate struct Node {
	let v: String
	let cd: [Node]
}
fileprivate func build(fromNode n: Node) -> Content {
	let c = createSDUIContent(n.v)
	if !n.cd.isEmpty {
		c.child = n.cd.map { build(fromNode: $0) }
	}
	return c
}
fileprivate func createSDUIContent(_ suffix: String) -> Content {
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
