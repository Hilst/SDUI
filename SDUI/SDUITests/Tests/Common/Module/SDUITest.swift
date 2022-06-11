import XCTest
@testable import SDUI

class SDUITest: XCTestCase {

    var sut: SDUIInterface!
    var providerMock: ProviderProtocol!

    override func setUp() {
        providerMock = ProviderMock()
//        sut = SDUI(provider: providerMock, initialRoute: Route(rawValue: "home"), linker: )
    }

    override func tearDown() {
        sut = nil
        providerMock = nil
    }

    func test_initializaion() {
//        XCTAssertNotNil(sut)

        // swiftlint:disable force_cast
//        XCTAssertEqual(sut.getViewModel() as! String, "something")
    }
}
