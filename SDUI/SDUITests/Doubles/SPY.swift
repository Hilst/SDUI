import Foundation

class SPY {

    private init() {/* NOT IMPLEMENTED ON PURPOSE */}

    private(set) static var integer: Int = 0

    public static func reset() {
        integer = 0
    }

    public static func add(_ more: NSInteger = 0) {
        integer += more
    }
}
