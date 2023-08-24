import Foundation
import SDUIModels

extension Content: Equatable {
	public static func == (lhs: SDUIModels.Content, rhs: SDUIModels.Content) -> Bool {
		return (
			lhs.id == rhs.id &&
			lhs.type == rhs.type &&
			lhs.data == rhs.data &&
			lhs.metadata == rhs.metadata &&
			lhs.child == rhs.child
		)
	}
}
