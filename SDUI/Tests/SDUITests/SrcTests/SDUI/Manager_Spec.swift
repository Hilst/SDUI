import Foundation
import XCTest
@testable import SDUI

final class Manager_Spec: XCTestCase {
	var sut: Manager<String>!
	var clientMock: ClientDouble!
	var mapperMock: MapperDouble!
	override func setUp() {
		sut = Manager()
		clientMock = ClientDouble()
		sut.client = clientMock
		mapperMock = MapperDouble()
		sut.mapper = mapperMock
		sut.renderer = { $0.id ?? "NULL" }
		sut.reset()
	}

	func test_happy_flux() {
		sut.start()
		XCTAssertEqual(sut.rendered, "test")
		XCTAssertEqual(clientMock!.called, 1)
		XCTAssertEqual(mapperMock!.called, 1)
	}
}

