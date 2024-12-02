enum ProductDetailsFactory {
    static func build(coordinator: any ProductDetailsCoordinatorProtocol,
                      image: String,
                      name: String,
                      description: String) -> ProductDetailsViewController {
        let viewModel = ProductDetailsViewModelFactory.buil(coordinator: coordinator,
                                                            image: image,
                                                            name: name,
                                                            description: description)
        return ProductDetailsViewController(viewModel: viewModel)
    }
}
