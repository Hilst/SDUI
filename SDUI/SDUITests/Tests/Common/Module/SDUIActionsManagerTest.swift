import XCTest
@testable import SDUI

class SDUIActionsManagerTest: XCTestCase {

    var sut: SDUIActionsManager!

    override func setUp() {
        super.setUp()
        sut = SDUIActionsManager()
        sut.logAllMethodsAvaible()
        SPY.reset()
    }

    override func tearDown() {
        sut = nil
    }

    func test_call_without_parameter() throws {
        XCTAssertEqual(SPY.integer, 0)

        sut.performAction(withSignature: "function")
        XCTAssertEqual(SPY.integer, 1)
    }

    func test_call_with_single_parameter() throws {
        XCTAssertEqual(SPY.integer, 0)

        sut.performAction(withSignature: "functionWithParameter:", andParameter: 2)
        XCTAssertEqual(SPY.integer, 2)
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

class SPY {

    private(set) static var integer: Int = 0

    public static func reset() {
        integer = 0
    }

    public static func add(_ more: NSInteger = 0) {
        integer += more
    }
}
