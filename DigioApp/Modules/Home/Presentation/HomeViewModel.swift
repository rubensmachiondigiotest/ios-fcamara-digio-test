protocol HomeViewModelProtocol {
    
}

enum HomeViewModelFactory {
    static func buil<Coordinator: HomeCoordinatorProtocol>(coordinator: Coordinator) -> HomeViewModelProtocol {
        let repository = HomeRepository()
        return HomeViewModel(repository: repository, coordinator: coordinator)
    }
}

final class HomeViewModel<Coordinator: HomeCoordinatorProtocol>: HomeViewModelProtocol {
    
    private let repository: HomeRepositoryProtocol
    private let coordinator: Coordinator
    
    init(repository: HomeRepositoryProtocol, coordinator: Coordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
}
