import UIKit

protocol HomeCoordinatorProtocol: CoordinatorProtocol where Event == HomeCoordinatorEvent { }

enum HomeCoordinatorEvent {
    case detail
}

final class HomeCoordinator<Coordinator: CoordinatorProtocol>: HomeCoordinatorProtocol {
    
    private weak var mainCoordinator: Coordinator?
    private weak var navigation: UINavigationController?
    
    init(mainCoordinator: Coordinator?, navigation: UINavigationController?) {
        self.mainCoordinator = mainCoordinator
        self.navigation = navigation
    }
    
    func start() {
        let viewController = HomeFactory.build(coordinator: self)
        navigation?.setViewControllers([viewController], animated: false)
    }
    
    func handle(event: HomeCoordinatorEvent) {
        switch event {
        case .detail:
            break
        }
    }
}
