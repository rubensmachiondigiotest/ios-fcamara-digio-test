import XCTest

@testable import DigioAppDev

final class HomeViewModelTests: XCTestCase {

    private lazy var refreshDataExpectation = self.expectation(description: "Refresh Home")
    private lazy var delegateSpy: HomeViewModelDelegateSpy = HomeViewModelDelegateSpy()
    
    private lazy var sut: HomeViewModel = {
        let repository = HomeRepositorySyp()
        let coordinator = HomeCoordinatorSpy()
        let viewModel = HomeViewModel(repository: repository,
                                      coordinator: coordinator)
        viewModel.delegate = self.delegateSpy
        
        return viewModel
    }()
    
    func test_refresh_home() throws {
        delegateSpy.notifyRefresh = { [weak self] in
            self?.refreshDataExpectation.fulfill()
        }
        
        sut.refreshData()
        
        wait(for: [refreshDataExpectation], timeout: 1.0)
        
        XCTAssert(sut.numberOfItems() > 0)
        XCTAssertNotNil(sut.itemAt(index: IndexPath(row: 0, section: 0)))
    }
}

// MARK: - Spy
private final class HomeRepositorySyp: HomeRepositoryProtocol {
    func getHomeData(completion: @escaping ([HomeRepositoryResponse]?, (any Error)?) -> Void) {
        let data: [HomeRepositoryResponse] = [
            .init(sectionName: "SectioName", items: [.init(name: "item1",
                                                           imageURL: "item1",
                                                           description: "item1")])
        ]
        completion(data, nil)
    }
}

private final class HomeCoordinatorSpy: HomeCoordinatorProtocol {
    func start() { }
    
    func handle(event: HomeCoordinatorEvent) { }
}

private final class HomeViewModelDelegateSpy: HomeViewModelDelegate {
    var notifyRefresh: (() -> Void)?
    
    func didRefreshData() {
        notifyRefresh?()
    }
}
