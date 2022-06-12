import XCTest
@testable import SDUI

class SDUIViewModelTest: XCTestCase {

    var sut: SDUIViewModel!
    var provider: ProviderMock!
    var linker: Linker!
    var stateMachine: SDUIStateMachine!

    override func setUp() {
        provider = ProviderMock()
        linker = LinkerMock()
        stateMachine = SDUIStateMachine(initialState: .start)

        sut = SDUIViewModel(initalRoute: .init(rawValue: "view-model-test"),
                            provider: provider,
                            linker: linker,
                            stateMachine: stateMachine)
    }

    override func tearDown() {
        sut = nil
        stateMachine = nil
        linker = nil
        provider = nil
    }

    func test_happy_flux() {
        XCTAssertEqual(provider.requestWasCalled, 1)
        XCTAssertEqual(sut.state, .present)
        XCTAssertFalse(sut.templates.isEmpty)
        XCTAssertEqual(sut.templates.count, 1)
        let template = sut.templates.first
        let component = template?.components.first
        XCTAssertNotNil(template)
        XCTAssertNotNil(component)
    }

    func test_sad_flux_fetch() {
        sut.goto(route: .init(rawValue: "sad-flux-route"))
        sut.changeState(with: .react)

        XCTAssertEqual(provider.requestWasCalled, 2)
        XCTAssertEqual(sut.state, .error)
        XCTAssertTrue(sut.templates.isEmpty)
    }

    func test_sad_flux_load() {
        sut.goto(route: .init(rawValue: "view-model-load-failure-test"))
        sut.changeState(with: .react)

        XCTAssertEqual(provider.requestWasCalled, 2)
        XCTAssertEqual(sut.state, .error)
        XCTAssertTrue(sut.templates.isEmpty)
    }
    
    func test_routing() {
        XCTAssertEqual(sut.route.rawValue, "view-model-test")
        sut.goto(route: .init(rawValue: "view-model-test-2"))
        XCTAssertEqual(sut.route.rawValue, "view-model-test-2")
        sut.goBack()
        XCTAssertEqual(sut.route.rawValue, "view-model-test")
    }


}
