import UIKit
import AppProtocols
import NetworkKit
import DesignSystem

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var mainCoordinator: (any MainCoordinatorProtocol)?
    
    // MARK: AppDelegate init
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerDependencies()
        
        mainCoordinator = MainCoordinator()
        mainCoordinator?.start()
        
        return true
    }
    
    private func registerDependencies() {
        DependencyContainer {
            Module {
                NetworkManagerFactory.build() as NetworkProtocol
            }
        }.build()
    }
}
