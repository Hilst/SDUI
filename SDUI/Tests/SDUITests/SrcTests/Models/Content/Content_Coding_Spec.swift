import XCTest
@testable import SDUIModels

final class Content_Coding_Spec: XCTestCase {

	var base: Content!
	var out: Content!
	let reader = Reader()

	override func setUp() {
		base = Content_Utils.createSDUIContent("1")
		base.child.append(Content_Utils.createSDUIContent("1-1"))
		base.child[0].child.append(Content_Utils.createSDUIContent("1-1-1"))
		base.child.append(Content_Utils.createSDUIContent("1-2"))
	}

	override func tearDown() {
		Content.setCodingKeys(newKeys: [
			.id: "id",
			.type: "type",
			.data: "data",
			.metadata: "metadata",
			.child: "child"
		])
	}

	func test_decoding_new_keys() throws {
		let data = try reader.mock()
		Content.setCodingKeys(newKeys: [ .id: "a" ])
		let out = try? JSONDecoder().decode(Content.self, from: data)
		XCTAssertNotNil(out)
		XCTAssertEqual(base, out)
	}
}

