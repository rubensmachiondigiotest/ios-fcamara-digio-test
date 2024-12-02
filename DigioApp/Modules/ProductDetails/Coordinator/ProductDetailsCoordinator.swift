import UIKit
import AppProtocols

protocol ProductDetailsCoordinatorProtocol: CoordinatorProtocol where Event == ProductDetailsCoordinatorEvent {
    func showErrorMessage(_ message: String)
}

enum ProductDetailsCoordinatorEvent {
    case detail
}

final class ProductDetailsCoordinator<Coordinator: MainCoordinatorProtocol>: ProductDetailsCoordinatorProtocol {
    
    private weak var mainCoordinator: Coordinator?
    private weak var navigation: UINavigationController?
    private let image: String
    private let name: String
    private let description: String
    
    init(mainCoordinator: Coordinator?,
         navigation: UINavigationController?,
         image: String,
         name: String,
         description: String) {
        self.mainCoordinator = mainCoordinator
        self.navigation = navigation
        self.image = image
        self.name = name
        self.description = description
    }
    
    func start() {
        let viewController = ProductDetailsFactory.build(coordinator: self,
                                                         image: image,
                                                         name: name,
                                                         description: description)
        navigation?.pushViewController(viewController, animated: true)
    }
    
    func handle(event: ProductDetailsCoordinatorEvent) {
        switch event {
        case .detail:
            break
        }
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Atenção",
                                      message: message,
                                      preferredStyle: .alert)
        
        navigation?.present(alert, animated: true)
    }
}
