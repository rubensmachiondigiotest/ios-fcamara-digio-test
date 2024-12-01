import Foundation

public enum RequestMethod: String {
    case get,
         post,
         put,
         delete
}

public enum RequestEncoding {
    case json,
         query
}

public protocol RequestProtocol {
    var sheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var path: String { get }
    var body: Encodable? { get }
    var headers: [String: String] { get }
    var method: RequestMethod { get }
    var encoding: RequestEncoding { get }
    
    func createURLRequest() -> URLRequest?
}
