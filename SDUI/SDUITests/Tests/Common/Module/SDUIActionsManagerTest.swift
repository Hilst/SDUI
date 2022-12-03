import XCTest
@testable import SDUI

class SDUIActionsManagerTest: XCTestCase {

    var sut: SDUIActionsManager!

    override func setUp() {
        super.setUp()
        sut = SDUIActionsManager()
        sut.logAllMethodsAvaible()
        sut.logAllMethodsAvaible(with: "parameter")
        SPY.reset()
    }

    override func tearDown() {
        sut = nil
    }

    func test_call_without_parameter() {
        XCTAssertEqual(SPY.integer, 0)

        sut.performAction(withSignature: "function")
        XCTAssertEqual(SPY.integer, 1)
    }

    func test_call_with_parameter() {
        XCTAssertEqual(SPY.integer, 0)

        sut.performAction(withSignature: "functionWithParameter:", andParameter: 2)
        XCTAssertEqual(SPY.integer, 2)
    }

    func test_call_invalid_parameter() {
        XCTAssertEqual(SPY.integer, 0)

        sut.performAction(withSignature: "asdfg")
        XCTAssertEqual(SPY.integer, 0)
    }
}

extension SDUIActionsManager {

    @objc
    public func function() {
        SPY.add(1)
    }

    @objc
    public func function(parameter: NSNumber) {
        let increment = parameter.intValue
        SPY.add(increment)
    }
}
