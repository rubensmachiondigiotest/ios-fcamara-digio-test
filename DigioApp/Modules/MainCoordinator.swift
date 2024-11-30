import UIKit

protocol MainCoordinatorProtocol: CoordinatorProtocol where Event == MainCoordinatorEvent { }

enum MainCoordinatorEvent {
    case productDetail
}

final class MainCoordinator: AnyObject, MainCoordinatorProtocol {
    
    private lazy var window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    private let navigation: UINavigationController = .init()
    
    init() {
        start()
    }
    
    func start() {
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        
        let coordinator = HomeCoordinator(mainCoordinator: self, navigation: navigation)
        coordinator.start()
    }
    
    func handle(event: MainCoordinatorEvent) {
        switch event {
        case .productDetail:
            print(event)
        }
    }
}
