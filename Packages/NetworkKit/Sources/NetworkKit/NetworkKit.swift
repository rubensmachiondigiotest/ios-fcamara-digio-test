import Foundation
import AppProtocols

public struct NetworkManagerFactory {
    public static func build() -> NetworkProtocol {
        NetworkManager()
    }
}

final class NetworkManager: NetworkProtocol {
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Decodable>(request: RequestProtocol, type: T.Type, completion: @escaping @Sendable (NetworkResponseResult<T>) -> Void) {
        guard let urlRequest = request.createURLRequest() else {
            completion(.failure(.notFound))
            return
        }
        
        let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error {
                print("Erro de rede: \(error.localizedDescription)")
                completion(.failure(.business))
                return
            }
            
            guard let data = data else {
                completion(.failure(.notFound))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let resultObject = try decoder.decode(T.self, from: data)
                completion(.success(resultObject))
            } catch {
                print("Erro ao decodificar JSON: \(error.localizedDescription)")
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
