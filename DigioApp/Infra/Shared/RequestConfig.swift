import Foundation
import AppProtocols

struct RequestConfig: RequestProtocol {
    // https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products
    var sheme: String = "https"
    var host: String = "7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com"
    var port: Int? = nil
    var path: String = ""
    var body: Encodable?
    var headers: [String : String] = [:]
    var method: RequestMethod = .get
    var encoding: RequestEncoding = .query
}

extension RequestProtocol {
    func createURLRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = sheme
        components.host = host
        components.port = port
        components.path = path
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        guard let body = body else {
            return request
        }
        
        guard let dataBody = try? JSONEncoder().encode(body) else {
            return request
        }
        
        switch encoding {
        case .json:
            request.httpBody = dataBody
        case .query:
            let json = try? JSONSerialization.jsonObject(with: dataBody) as? [String: Any]
            let query = json?.queryString()
            components.query = query
            guard let url = components.url else {
                return nil
            }
            request.url = url
        }
        
        return request
    }
}
