import Foundation

internal extension String {
    func replace(pattern: String, with char: Character) -> String {
        guard
            let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
        else {
            return self
        }
        let range = NSRange(location: 0, length: self.count)
        let substitution = String(char)
        return regex.stringByReplacingMatches(in: self, range: range, withTemplate: substitution)
    }
}
