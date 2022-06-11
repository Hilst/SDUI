import Foundation

public protocol ProviderProtocol: AnyObject {
    func request(screenName: String, completion: @escaping ((Result<Data?, Error>, Int) -> Void))
}

final class Service {
    private let provider: ProviderProtocol

    private lazy var emptyScreen: ScreenModel = {
        ScreenModel(screenName: "empty-screen",
                    templates: [])
    }()

    init(provider: ProviderProtocol) {
        self.provider = provider
    }

    func get(screenName: String) -> ScreenModel {

        var screen: ScreenModel!

        provider.request(screenName: screenName) { result, status in

            switch result {
            case .success(let data):
                if let jsonData = data {
                    let builder = ScreenBuilder(data: jsonData)
                    screen =  builder.getScreen()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return screen ?? emptyScreen
    }
}
