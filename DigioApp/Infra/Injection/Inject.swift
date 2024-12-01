@propertyWrapper
final class Inject<Value> {
    private let name: String?
    private var storage: Value?
    
    var wrappedValue: Value {
        storage ?? {
            let value: Value = DependencyContainer.standard.resolve(for: name)
            storage = value
            return value
        }()
    }
    
    init() {
        self.name = nil
    }
    
    init(_ name: String) {
        self.name = name
    }
}
