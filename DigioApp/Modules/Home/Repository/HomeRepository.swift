protocol HomeRepositoryProtocol {
    func getHomeData(completion: @escaping ([HomeRepositoryResponse]?, Error?) -> Void)
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
    
    func getHomeData(completion: @escaping ([HomeRepositoryResponse]?, Error?) -> Void) {
        service.fetchData { result in
            switch result {
            case .success(let response):
                let list = HomeRepositoryResponse.map(api: response)
                completion(list, nil)
    
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

// MARK: - Init API Response
fileprivate extension HomeRepositoryResponse {
    static func map(api response: HomeServiceFetchModel.Response) -> [HomeRepositoryResponse] {
        let spotlight = HomeRepositoryResponse.map(list: response.spotlight ?? [])
        let products = HomeRepositoryResponse.map(list: response.products ?? [])
        let cash = HomeRepositoryItemResponse(name: response.cash?.name ?? "",
                                              imageURL: response.cash?.bannerURL ?? (response.cash?.imageURL ?? ""),
                                              description: response.cash?.description ?? "")
        
        return [
            HomeRepositoryResponse(sectionName: "",
                                   identifier: HomeBannerViewCell.identifier,
                                   items: spotlight),
            HomeRepositoryResponse(sectionName: "digio Cash",
                                   identifier: HomeBannerViewCell.identifier,
                                   items: [cash]),
            HomeRepositoryResponse(sectionName: "Produtos",
                                   identifier: HomeMenuViewCell.identifier,
                                   items: products)
        ]
    }
    
    private static func map(list: [ResponseItem]?) -> [HomeRepositoryItemResponse] {
        let result: [HomeRepositoryItemResponse] = list?.compactMap {
            .init(name: $0.name ?? "",
                  imageURL: $0.bannerURL ?? ($0.imageURL ?? ""),
                  description: $0.description ?? "")
        } ?? []
        
        return result
    }
}
