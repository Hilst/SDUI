import Foundation
import SDUI

extension SDUIActionsManager {

    @objc
    func goto(detail: NSString) {
        let detailName = detail as String
        self.viewModel?.goto(route: .init(rawValue: detailName))
    }
}
