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
        var components: [ComponentModel] = []
        components.append(ComponentModel(id: "component-1", type: .test, body: body))
        components.append(ComponentModel(id: "component-2", type: .test, body: body))
        let template = TemplateModel(id: "template", type: .test, components: components)
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

    // MARK: - TEST FOR EQUATABLE
    func test_equatable_when_equal() {

        let modelLHS = TemplateModel(id: "equal", type: .test, components: [])
        let templateLHS = Template(model: modelLHS)
        let modelRHS = TemplateModel(id: "equal", type: .test, components: [])
        let templateRHS = Template(model: modelRHS)

        XCTAssertTrue(templateLHS == templateRHS)
    }

    func test_equatable_when_not_equal() {

        let modelLHS = TemplateModel(id: "LHS", type: .test, components: [])
        let templateLHS = Template(model: modelLHS)
        let modelRHS = TemplateModel(id: "RHS", type: .test, components: [])
        let templateRHS = Template(model: modelRHS)

        XCTAssertFalse(templateLHS == templateRHS)
    }
}
