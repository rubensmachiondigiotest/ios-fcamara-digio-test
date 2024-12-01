import AppProtocols

enum HomeServiceFetchResult {
    case success(HomeServiceFetchModel.Response)
    case failure(Error)
}

protocol HomeServiceProtocol {
    func fetchData(completion: @escaping (HomeServiceFetchResult) -> Void)
}

enum HomeServiceFactory {
    static func build() -> HomeServiceProtocol {
        let network: NetworkProtocol = DependencyContainer.standard.resolve()
        return HomeService(networkManager: network)
    }
}

final class HomeService: HomeServiceProtocol {
    
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchData(completion: @escaping (HomeServiceFetchResult) -> Void) {
        let request = HomeServiceFetchModel.Request.config
        
        networkManager.fetch(request: request,
                             type: HomeServiceFetchModel.Response.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }
}
