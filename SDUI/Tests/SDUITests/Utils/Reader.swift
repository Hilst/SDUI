import Foundation

struct Reader {
	public func readJson(pathNoExtension path: String) -> Data? {
		guard
			let url = Bundle.module.url(forResource: path, withExtension: "json")
		else { return nil }

		return try? Data(contentsOf: url)
	}
}
