import Foundation

public enum NetworkError: Error, Decodable {
    case notFound,
         business,
         invalidData
}

public enum NetworkResponseResult<T: Decodable> {
    case success(T)
    case failure(NetworkError)
}

public protocol NetworkProtocol {
    func fetch<T: Decodable>(request: RequestProtocol, type: T.Type, completion: @escaping @Sendable (NetworkResponseResult<T>) -> Void)
}
