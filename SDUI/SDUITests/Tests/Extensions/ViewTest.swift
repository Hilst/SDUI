import XCTest
import SwiftUI
@testable import SDUI


class ViewTest: XCTestCase {

    var sut: EmptyView!

    override func setUp() {
        sut = EmptyView()
    }

    override func tearDown() {
        sut = nil
    }

    func test_to_any_view() {
        XCTAssertNotNil(sut.toAnyView() as AnyView)
    }
}
