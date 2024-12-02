import UIKit
import DesignSystem

final class HomeMenuViewCell: HomeViewCell {
    
    static let identifier = String(describing: HomeMenuViewCell.self)
    
    private var selectItem: ((Int) -> Void)?
    
    private lazy var menuView: HorizontalMenuView = {
        let view = HorizontalMenuView()
        view.delegate = self
        
        return view
    }()
    
    override func setData(_ data: HomeRepositoryResponse,
                          selectItem: @escaping ((Int) -> Void)) {
        addListView(menuView)
        self.selectItem = selectItem
        
        super.title = data.sectionName
        let urlList = data.items.compactMap { $0.imageURL }
        menuView.setData(urlList: urlList)
    }
}

// MARK: - HorizontalMenuViewDelegate
extension HomeMenuViewCell: HorizontalMenuViewDelegate {
    func didSelectIndex(_ index: Int) {
        selectItem?(index)
    }
}
