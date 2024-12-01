struct Module {
    let name: String,
        resolve: () -> Any
    
    init<T>(_ name: String? = nil, _ resolve: @escaping () -> T) {
        self.name = name ?? String(describing: T.self)
        self.resolve = resolve
    }
}
