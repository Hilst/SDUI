import Foundation
import SDUI

final class Provider: ProviderProtocol {
    func request(screenName: String, completion: @escaping ((Result<Data?, Error>, Int) -> Void)) {

        var result: Result<Data?, Error>

        let bundle = Bundle.main
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
