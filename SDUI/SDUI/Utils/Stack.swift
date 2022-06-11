import Foundation

class Stack<T> {

    private var array = [T]()

    public var size: Int {
        array.count
    }

    func pop() -> T? {
        array.popLast()
    }

    func peek() -> T? {

        let index = array.endIndex - 1

        guard index >= 0 else { return nil }
        return array[ index ]
    }

    func push(_ newElement: T) {
        array.append(newElement)
    }
}
