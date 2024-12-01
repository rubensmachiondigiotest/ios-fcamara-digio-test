import Foundation

protocol HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate? { get set }
    
    func refreshData()
    func numberOfItems() -> Int
    func itemAt(index: IndexPath) -> HomeRepositoryResponse?
}

protocol HomeViewModelDelegate: AnyObject {
    func didRefreshData()
    func didLoadUserInformation(name: String)
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
                self?.response = nil
                DispatchQueue.main.async {
                    self?.delegate?.didRefreshData()
                    self?.coordinator.showErrorMessage(error.localizedDescription)
                }
                return
            }
            self?.response = response
            self?.delegate?.didRefreshData()
            self?.delegate?.didLoadUserInformation(name: "Maria")
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
