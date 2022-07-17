import XCTest
import SwiftUI
import ViewInspector
@testable import SDUI

class TemplateTest: XCTestCase {

    var sut: Template!
    var linker: Linker!

    override func setUp() {
        linker = LinkerMock()

        let data = ["test": "test"]
        let body = BodyModel(id: "body", data: data)
        let component = ComponentModel(id: "component", type: .test, body: body)
        let template = TemplateModel(id: "template", type: .test, components: [component])
        sut = linker.initializer(for: template)
        sut.linker = linker
    }

    override func tearDown() {
        sut = nil
    }

    func test_load_no_linker() {
        sut.linker = nil
        sut.load()
        XCTAssertTrue(sut.components.isEmpty)
    }

    func test_load() {
        sut.load()
        XCTAssertFalse(sut.components.isEmpty)
    }

    func test_render() throws {
        sut.load()
        let testableViewIsAbsent = try sut.render()
            .inspect()
            .anyView()
            .view(TestableView.self)
            .isAbsent

        XCTAssertFalse(testableViewIsAbsent)
    }

    func test_render_without_loading() throws {
        let emptyViewIsAbsent = try sut.render()
            .inspect()
            .view(EmptyView.self)
            .isAbsent

        XCTAssertFalse(emptyViewIsAbsent)
    }
}
