import XCTest
@testable import SDUI

final class Content_Spec: XCTestCase {

	var base: Content!
	var out: Content!
	let reader = Reader()

	override func setUp() {
		base = Content_Utils.createSDUIContent("1")
		base.child.append(Content_Utils.createSDUIContent("1-1"))
		base.child[0].child.append(Content_Utils.createSDUIContent("1-1-1"))
		base.child.append(Content_Utils.createSDUIContent("1-2"))
	}

	func test_decoding() throws {
		let data = try reader.mock()
		let out = try? JSONDecoder().decode(Content.self, from: data)
		XCTAssertNotNil(out)
		XCTAssertEqual(base, out)
	}
}

