public protocol CoordinatorProtocol: AnyObject {
    associatedtype Event
    
    func start()
    func handle(event: Event)
}
