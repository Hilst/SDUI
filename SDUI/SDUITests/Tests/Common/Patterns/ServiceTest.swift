import Foundation
import XCTest
@testable import SDUI

final class ServiceTest: XCTestCase {

    var sut: Service!
    var providerMock: ProviderMock!

    override func setUp() {
        providerMock = ProviderMock()
        sut = Service(provider: providerMock)
    }

    override func tearDown() {
        sut = nil
        providerMock = nil
    }

    func test_request() {

        let out = sut.get(screenName: "service-test")

        XCTAssertTrue(providerMock.requestWasCalled)

        ScreenLogger.log(out)

        XCTAssertEqual(out.screenName, "test-data")

        let template = out.templates[0]
        XCTAssertEqual(template.id, "template")
        XCTAssertEqual(template.type.rawValue, "zero")

        let component = template.components[0]
        XCTAssertEqual(component.id, "componente")
        XCTAssertEqual(component.type.rawValue, "zero")

        let body = component.body
        XCTAssertEqual(body.id, "corpo")
        XCTAssertEqual(body.data["nome"], "A")
    }

    func test_request_error() {

        let out = sut.get(screenName: "wrong-name")

        XCTAssertTrue(providerMock.requestWasCalled)

        ScreenLogger.log(out)

        XCTAssertEqual(out.screenName, "empty-screen")

        XCTAssertTrue(out.templates.isEmpty)
    }
}
