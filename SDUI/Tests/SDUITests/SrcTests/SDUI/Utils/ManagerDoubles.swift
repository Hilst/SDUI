import Foundation
import SDUI

final class ClientDouble: Client {
	var ok: Bool = true
	var label: String = "test"
	var called = 0
	func request(complete: @escaping ((Result<Data, Error>) -> Void)) {
		called += 1
		if self.ok {
			complete(.success(Data(label.utf8)))
		}
		complete(.failure(NSError(domain: "client", code: -1)))
	}
}

final class MapperDouble: Mapper {
	var ok: Bool = true
	var called = 0
	func getContent(from data: Data) -> Result<SDUI.Content, Error> {
		called += 1
		if self.ok, let str = String(data: data, encoding: .utf8) {
			let c = Content()
			c.id = str
			return .success(c)
		}
		return .failure(NSError(domain: "mapper", code: -2))
	}
}
