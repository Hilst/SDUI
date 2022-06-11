import XCTest
@testable import SDUI

final class ScreenBuilderTest: XCTestCase {

    var sut: ScreenBuilder!

    override func setUp() {

        let bundle = Bundle(for: type(of: self))
        guard
            let url = bundle.url(forResource: "screen-builder-test", withExtension: "json"),
            let jsonData = try? Data(contentsOf: url, options: .mappedIfSafe)
        else { return }

        sut = ScreenBuilder(data: jsonData)
    }

    override func tearDown() {
        sut = nil
    }

    func test_get_screen() throws {

        let out = sut.getScreen()

        ScreenLogger.log(out)

        XCTAssertEqual(out.screenName, "test-data")

        let template1 = out.templates[0]
        XCTAssertEqual(template1.id, "primeiro-template")
        XCTAssertEqual(template1.type.rawValue, "zero")

        let component11 = template1.components[0]
        XCTAssertEqual(component11.id, "primeiro-componente")
        XCTAssertEqual(component11.type.rawValue, "zero")

        let body11 = component11.body
        XCTAssertEqual(body11.id, "primeiro-corpo")
        XCTAssertEqual(body11.data["nome"], "A")

        let component12 = template1.components[1]
        XCTAssertEqual(component12.id, "segundo-component")
        XCTAssertEqual(component12.type.rawValue, "one")

        let body12 = component12.body
        XCTAssertEqual(body12.id, "segundo-corpo")
        XCTAssertEqual(body12.data["nome"], "B")

        let template2 = out.templates[1]
        XCTAssertEqual(template2.id, "segundo-template")
        XCTAssertEqual(template2.type.rawValue, "one")

        let component21 = template2.components[0]
        XCTAssertEqual(component21.id, "terceiro-componente")
        XCTAssertEqual(component21.type.rawValue, "two")

        let body21 = component21.body
        XCTAssertEqual(body21.id, "terceiro-corpo")
        XCTAssertEqual(body21.data["nome"], "C")
    }

    func test_get_screen_when_errors() {

        let emptyData = Data()
        sut = ScreenBuilder(data: emptyData)

        let out = sut.getScreen()

        ScreenLogger.log(out)

        XCTAssertEqual(out.screenName, "")

        XCTAssertTrue(out.templates.isEmpty)
    }
}
