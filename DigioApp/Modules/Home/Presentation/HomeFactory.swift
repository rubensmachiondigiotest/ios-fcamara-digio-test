enum HomeFactory {
    static func build(coordinator: any HomeCoordinatorProtocol) -> HomeViewController {
        let viewModel = HomeViewModelFactory.buil(coordinator: coordinator)
        return HomeViewController(viewModel: viewModel)
    }
}
