import Foundation

public extension Array where Iterator.Element: Equatable {
    mutating func insertWithoutRepetition(_ element: Iterator.Element) {
        if self.firstIndex(of: element) == nil {
            self.append(element)
        }
    }
}
