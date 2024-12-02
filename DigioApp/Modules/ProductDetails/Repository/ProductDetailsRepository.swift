protocol ProductDetailsRepositoryProtocol {

}

enum ProductDetailsRepositoryFactory {
    static func build() -> ProductDetailsRepositoryProtocol {
        return ProductDetailsRepository()
    }
}

final class ProductDetailsRepository: ProductDetailsRepositoryProtocol {
    
    init() {
        
    }
}
