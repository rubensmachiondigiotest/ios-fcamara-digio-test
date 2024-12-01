import XCTest
import AppProtocols

@testable import DigioAppDev

final class HomeViewModelTests: XCTestCase {

    private lazy var refreshDataExpectation = self.expectation(description: "Refresh Home")
    private lazy var delegateSpy: HomeViewModelDelegateSpy = HomeViewModelDelegateSpy()
    private lazy var repository = HomeRepositorySpy()
    private lazy var coordinator = HomeCoordinatorSpy()
    
    private lazy var sut: HomeViewModel = {
        let viewModel = HomeViewModel(repository: repository,
                                      coordinator: coordinator)
        viewModel.delegate = self.delegateSpy
        
        return viewModel
    }()
    
    /// It should test success load data
    func test_refresh_home() throws {
        delegateSpy.notifyRefresh = { [weak self] in
            self?.refreshDataExpectation.fulfill()
        }
        repository.shouldReturnError = false
        sut.refreshData()
        
        wait(for: [refreshDataExpectation], timeout: 1.0)
        
        XCTAssert(sut.numberOfItems() > 0)
        XCTAssertNotNil(sut.itemAt(index: IndexPath(row: 0, section: 0)))
    }
    
    /// It should test error load data
    func test_refresh_error_home() throws {
        delegateSpy.notifyRefresh = { [weak self] in
            self?.refreshDataExpectation.fulfill()
        }
        repository.shouldReturnError = true
        sut.refreshData()
        
        wait(for: [refreshDataExpectation], timeout: 1.0)
        
        XCTAssertTrue(coordinator.isErrorShowed)
    }
}

// MARK: - Spy

private final class HomeRepositorySpy: HomeRepositoryProtocol {
    
    var shouldReturnError: Bool = false
    
    func getHomeData(completion: @escaping ([HomeRepositoryResponse]?, (any Error)?) -> Void) {
        guard !shouldReturnError else {
            completion(nil, NetworkError.invalidData)
            return
        }
        
        let data: [HomeRepositoryResponse] = [
            .init(sectionName: "SectioName", items: [.init(name: "item1",
                                                           imageURL: "item1",
                                                           description: "item1")])
        ]
        completion(data, nil)
    }
}

private final class HomeCoordinatorSpy: HomeCoordinatorProtocol {
    var isErrorShowed = false
    
    func start() { }
    
    func handle(event: HomeCoordinatorEvent) { }
    
    func showErrorMessage(_ message: String) {
        isErrorShowed = true
    }
}

private final class HomeViewModelDelegateSpy: HomeViewModelDelegate {
    
    var notifyRefresh: (() -> Void)?
    var notifyLoadUserInformation: (() -> Void)?
    
    func didRefreshData() {
        notifyRefresh?()
    }
    
    func didLoadUserInformation(name: String) {
        notifyLoadUserInformation?()
    }
}
