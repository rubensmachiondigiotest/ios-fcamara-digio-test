import Foundation

protocol HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate? { get set }
    
    func refreshData()
    func numberOfItems() -> Int
    func itemAt(index: IndexPath) -> HomeRepositoryResponse?
}

protocol HomeViewModelDelegate: AnyObject {
    func didRefreshData()
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
    
    weak var delegate: HomeViewModelDelegate?
    
    private var response: [HomeRepositoryResponse]?
    
    init(repository: HomeRepositoryProtocol, coordinator: Coordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func refreshData() {
        repository.getHomeData { [weak self] response, error in
            if let error = error {
                // TODO: Show error
                return
            }
            self?.response = response
            self?.delegate?.didRefreshData()
        }
    }
    
    func numberOfItems() -> Int {
        response?.count ?? 0
    }
    
    func itemAt(index: IndexPath) -> HomeRepositoryResponse? {
        guard let data = response?[index.row] else {
            return nil
        }
        
        return data
    }
}
