import Foundation

struct Reader {
	enum ValidExtensions: String {
		case json
	}
	func read(path: String, extension ext: ValidExtensions) throws -> Data {
		print("READING MOCK \(path).\(ext.rawValue)")
		guard let url = Bundle.module.url(forResource: path, withExtension: ext.rawValue)
		else { throw Self.ReaderError.missingFile }
		return try Data(contentsOf: url)
	}
	func mock(_ caller: String = #function, _ testFile: String = #file, extension ext: ValidExtensions = .json) throws -> Data {
		var fileName = testFile.lowercased().split(separator: "/").last
		fileName?.removeLast(6) // remove ".swift"
		let functionName = caller.lowercased().dropLast(2) // remove"()"
		return try self.read(path: "\(fileName ?? "")_\(functionName)", extension: ext)
	}
	enum ReaderError: Error {
		case missingFile
	}
}
