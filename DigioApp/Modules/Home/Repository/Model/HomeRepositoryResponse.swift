public struct HomeRepositoryResponse {
    let sectionName: String
    let identifier: String
    let items: [HomeRepositoryItemResponse]
}

public struct HomeRepositoryItemResponse {
    let name: String
    let imageURL: String
    let description: String
}
