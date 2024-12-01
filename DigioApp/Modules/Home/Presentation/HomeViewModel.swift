protocol HomeViewModelProtocol {
    func refreshData()
}

enum HomeViewModelFactory {
    static func buil<Coordinator: HomeCoordinatorProtocol>(coordinator: Coordinator) -> HomeViewModelProtocol {
        let repository = HomeRepositoryFactory.build()
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
    
    func refreshData() {
        repository.getHomeData { response, error in
            if let error = error {
                // TODO: Show error
                return
            }
            
            print(response)
        }
    }
}
