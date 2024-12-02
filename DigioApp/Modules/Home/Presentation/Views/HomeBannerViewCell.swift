import DesignSystem
import UIKit

final class HomeBannerViewCell: HomeViewCell {
    
    static let identifier = String(describing: HomeBannerViewCell.self)
    
    private lazy var carouselView: CarouselView = {
        let view = CarouselView(itemSize: self.itemSize)
        view.backgroundColor = .groupTableViewBackground
        view.heightAnchor.constraint(equalToConstant: self.itemSize.width * 0.5).isActive = true
        view.delegate = self
        
        return view
    }()
    
    private var itemSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width - 40.0
        let height = width * 0.45
        let size: CGSize = CGSize(width: width, height: height)
        
        return size
    }
    
    override func setData(_ data: HomeRepositoryResponse) {
        addListView(carouselView)
        
        super.title = data.sectionName
        let urlList = data.items.compactMap { $0.imageURL }
        carouselView.setData(urlList: urlList)
        carouselView.layoutIfNeeded()
    }
}

// MARK: - CarouselViewDelegate
extension HomeBannerViewCell: CarouselViewDelegate {
    public func didSelectIndex(_ index: IndexPath) {
        print(index)
    }
}
