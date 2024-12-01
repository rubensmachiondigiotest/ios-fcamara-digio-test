import AppProtocols

struct HomeServiceFetchModel {
    
    struct Request {
        static var config: RequestProtocol {
            RequestConfig(path: "/sandbox/products")
        }
    }
    
    struct Response: Decodable {
        let spotlight: [ResponseItem]?
        let products: [ResponseItem]?
        let cash: ResponseItem?
    }
}
