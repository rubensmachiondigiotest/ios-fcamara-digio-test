import XCTest
import Foundation
import AppProtocols
import Mocker

@testable import NetworkKit

final class NetworkManagerTests: XCTestCase {
    
    private lazy var sut: NetworkManager = {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let urlSession = URLSession(configuration: configuration)
        
        let sut = NetworkManager(urlSession: urlSession)
        
        return sut
    }()
    
    /// Test if API calls working correctly
    func test_success_request_network() throws {
        let requestSpy = RequestConfigSpy()
        let expectedResponse = MockResponseSpy(param1: "Param 1", param2: "Param 2")
        let requestExpectation = expectation(description: "Wait network request")
        
        let mockedData = try! JSONEncoder().encode(expectedResponse)
        let request = requestSpy.createURLRequest()!
        let mock = Mock(request: request, statusCode: 200, data: mockedData)
        mock.register()
        
        sut.fetch(request: requestSpy,
                  type: MockResponseSpy.self) { result in
            defer { requestExpectation.fulfill() }
            switch result {
            case .success(let response):
                XCTAssert(response == expectedResponse)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [requestExpectation], timeout: 2.0)
    }
}

fileprivate struct MockResponseSpy: Codable, Equatable {
    let param1: String
    let param2: String
}

fileprivate struct RequestConfigSpy: RequestProtocol {
    var sheme: String = "https"
    var host: String = "validurl.com"
    var port: Int?
    var path: String = "/some/path"
    var body: Encodable?
    var headers: [String : String] = [:]
    var method: RequestMethod = .get
    var encoding: RequestEncoding = .query
    
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
        
        return request
    }
}
