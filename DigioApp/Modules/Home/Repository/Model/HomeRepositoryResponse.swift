struct HomeRepositoryResponse {
    let sectionName: String
    let items: [HomeRepositoryItemResponse]
}

struct HomeRepositoryItemResponse {
    let name: String
    let imageURL: String
    let description: String
}

