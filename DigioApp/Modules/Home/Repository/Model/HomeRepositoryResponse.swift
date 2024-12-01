struct HomeRepositoryResponse {
    let section: [String: [HomeRepositoryItemResponse]]
}

struct HomeRepositoryItemResponse {
    let name: String
    let imageURL: String
    let description: String
}

// MARK: - Init API Response
extension HomeRepositoryResponse {
    init(api response: HomeServiceFetchModel.Response) {
        let spotlight = HomeRepositoryResponse.map(list: response.spotlight ?? [])
        let products = HomeRepositoryResponse.map(list: response.products ?? [])
        let cash = HomeRepositoryItemResponse(name: response.cash?.name ?? "",
                                              imageURL: response.cash?.bannerURL ?? (response.cash?.imageURL ?? ""),
                                              description: response.cash?.description ?? "")
        
        self.section = [
            "Recarga": spotlight,
            "digio Cash": [cash],
            "Produtos": products
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
