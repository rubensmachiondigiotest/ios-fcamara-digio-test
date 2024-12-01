import UIKit

final class HomeButtonViewCell: HomeBannerViewCell {
    
    static let identifierButtonCell = String(describing: HomeButtonViewCell.self)
    
    override var itemSize: CGSize {
        return .init(width: 200, height: 200)
    }
}
