import Foundation
import SDUI

final class ProviderMock: ProviderProtocol {
    var requestWasCalled = false

    func request(screenName: String, completion: @escaping ((Result<Data?, Error>, Int) -> Void)) {
        requestWasCalled = true

        var result: Result<Data?, Error>

        let bundle = Bundle(for: type(of: self))
        guard
            let url = bundle.url(forResource: screenName, withExtension: "json"),
            let jsonData = try? Data(contentsOf: url, options: .mappedIfSafe)
        else {
            result = .failure(ProviderMockError())
            completion(result, 404)
            return
        }

        result = .success(jsonData)
        completion(result, 200)
    }
}

struct ProviderMockError: Error { }
