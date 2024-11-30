protocol HomeRepositoryProtocol {
    
}

enum HomeRepositoryFactory {
    static func build() -> HomeRepositoryProtocol {
        HomeRepository()
    }
}

final class HomeRepository: HomeRepositoryProtocol {
    
}
