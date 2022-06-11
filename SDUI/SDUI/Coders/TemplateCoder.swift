import Foundation

struct TemplateCoder: Codable {
    var id: String
    var type: String
    var order: Int
    var componentsId: [String]
}
