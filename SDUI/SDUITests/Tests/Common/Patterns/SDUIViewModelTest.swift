import XCTest
@testable import SDUI

class SDUIViewModelTest: XCTestCase {

    var sut: SDUIViewModel!
    var router: Router!
    var provider: ProviderMock!
    var linker: Linker!
    var stateMachine: SDUIStateMachine!

    override func setUp() {
        router = Router(initialRoute: .init(rawValue: "view-model-test"))
        provider = ProviderMock()
        linker = LinkerMock()
        stateMachine = SDUIStateMachine(initialState: .start)

        sut = SDUIViewModel(router: router,
                            provider: provider,
                            linker: linker,
                            stateMachine: stateMachine)
    }

    override func tearDown() {
        sut = nil
        stateMachine = nil
        linker = nil
        provider = nil
        router = nil
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
        XCTAssertEqual(router.current().rawValue, "view-model-test")
        sut.goto(route: .init(rawValue: "view-model-test-2"))
        XCTAssertEqual(router.current().rawValue, "view-model-test-2")
        sut.goBack()
        XCTAssertEqual(router.current().rawValue, "view-model-test")
    }


}
