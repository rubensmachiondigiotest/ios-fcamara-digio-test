import UIKit
import DesignSystem

final class HomeMenuViewCell: HomeViewCell {
    
    static let identifier = String(describing: HomeMenuViewCell.self)
    
    private lazy var carouselView: HorizontalMenuView = {
        let view = HorizontalMenuView()
        view.delegate = self
        
        return view
    }()
    
    override func setData(_ data: HomeRepositoryResponse) {
        addListView(carouselView)
        
        super.title = data.sectionName
        let urlList = data.items.compactMap { $0.imageURL }
        carouselView.setData(urlList: urlList)
    }
}

// MARK: - HorizontalMenuViewDelegate
extension HomeMenuViewCell: HorizontalMenuViewDelegate {
    func didSelectIndex(_ index: IndexPath) {
        print(index)
    }
}
