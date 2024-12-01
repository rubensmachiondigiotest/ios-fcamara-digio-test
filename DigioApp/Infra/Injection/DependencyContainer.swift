import Foundation

final class DependencyContainer {
    static var standard = DependencyContainer()
    
    private var modules = [String: Module]()
    
    init(@ModuleBuilder _ modules: () -> [Module]) {
        modules().forEach { add(module: $0) }
    }
    
    init(@ModuleBuilder _ module: () -> Module) {
        add(module: module())
    }
    
    fileprivate init() {}
    deinit { modules.removeAll() }
    
    func build() {
        Self.standard.modules.append(with: self.modules)
    }
}

extension DependencyContainer {
    func add(module: Module) {
        modules[module.name] = module
    }

    func resolve<T>(for name: String? = nil) -> T {
        let name = name ?? String(describing: T.self)
        
        guard let component: T = modules[name]?.resolve() as? T else {
            fatalError("Dependency '\(T.self)' not resolved!")
        }
        
        return component
    }
}

extension DependencyContainer {
    @resultBuilder
    struct ModuleBuilder {
        static func buildBlock(_ modules: Module...) -> [Module] { modules }
        static func buildBlock(_ module: Module) -> Module { module }
    }
}
