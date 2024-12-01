protocol HomeRepositoryProtocol {
    func getHomeData(completion: @escaping (HomeRepositoryResponse?, Error?) -> Void)
}

enum HomeRepositoryFactory {
    static func build() -> HomeRepositoryProtocol {
        let service = HomeServiceFactory.build()
        return HomeRepository(service: service)
    }
}

final class HomeRepository: HomeRepositoryProtocol {
    
    private let service: HomeServiceProtocol
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    func getHomeData(completion: @escaping (HomeRepositoryResponse?, Error?) -> Void) {
        service.fetchData { result in
            switch result {
            case .success(let response):
                let parser = HomeRepositoryResponse(api: response)
                completion(parser, nil)
    
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
