import Foundation

protocol ProductDetailsViewModelProtocol {
    
    var delegate: ProductDetailsViewModelDelegate? { get set }
    
    func refresh()
}

protocol ProductDetailsViewModelDelegate: AnyObject {
    func didUpdateInfo(imageURL: String, name: String, description: String)
}

enum ProductDetailsViewModelFactory {
    static func buil<Coordinator: ProductDetailsCoordinatorProtocol>(coordinator: Coordinator,
                                                                     image: String,
                                                                     name: String,
                                                                     description: String) -> ProductDetailsViewModelProtocol {
        let repository = ProductDetailsRepositoryFactory.build()
        return ProductDetailsViewModel(repository: repository,
                                       coordinator: coordinator,
                                       image: image,
                                       name: name,
                                       description: description)
    }
}

final class ProductDetailsViewModel<Coordinator: ProductDetailsCoordinatorProtocol>: ProductDetailsViewModelProtocol {
    
    private let repository: ProductDetailsRepositoryProtocol
    private let coordinator: Coordinator
    
    weak var delegate: ProductDetailsViewModelDelegate?
    
    private let image: String
    private let name: String
    private let description: String
    
    init(repository: ProductDetailsRepositoryProtocol,
         coordinator: Coordinator,
         image: String,
         name: String,
         description: String) {
        self.repository = repository
        self.coordinator = coordinator
        self.image = image
        self.name = name
        self.description = description
    }
    
    func refresh() {
        delegate?.didUpdateInfo(imageURL: image,
                                name: name,
                                description: description)
    }
}
