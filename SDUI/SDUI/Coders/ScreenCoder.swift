import Foundation

struct ScreenCoder: Codable {
    var screenName: String
    var templates: [TemplateCoder]
    var components: [ComponentCoder]
    var bodies: [BodyCoder]
}
