import DesignSystem
import UIKit

open class HomeBannerViewCell: UITableViewCell {
    
    static let identifier = String(describing: HomeBannerViewCell.self)
    
    // MARK: - UI
    
    private lazy var vContainerStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        
        return view
    }()
    
    private lazy var titleContainerStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 20, left: 20, bottom: 0, right: 20)
        
        return view
    }()
    
    private lazy var titleSectionLabel = UILabel.build(size: .title,
                                                       weight: .bold,
                                                       textColor: Colors.Neutral.primaryTextColor.uiColor)
    
    private lazy var carouselView: CarouselView = {
        let view = CarouselView(itemSize: self.itemSize)
        view.backgroundColor = .groupTableViewBackground
        view.heightAnchor.constraint(equalToConstant: self.itemSize.width * 0.5).isActive = true
        
        return view
    }()
    
    open var itemSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width - 40.0
        let height = width * 0.5
        let size: CGSize = CGSize(width: width, height: height)
        
        return size
    }
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: HomeRepositoryResponse) {
        titleSectionLabel.text = data.sectionName
        let urlList = data.items.compactMap { $0.imageURL }
        carouselView.setData(urlList: urlList)
    }
}

// MARK: - ViewConfiguration
extension HomeBannerViewCell: ViewConfiguration {
    public func configViews() {
        contentView.backgroundColor = Colors.Background.primaryBackground.uiColor
    }
    
    public func buildViews() {
        titleContainerStack.addArrangedSubview(titleSectionLabel)
        
        vContainerStack.addArrangedSubview(titleContainerStack)
        vContainerStack.addArrangedSubview(carouselView)
        
        contentView.addSubview(vContainerStack)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            vContainerStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vContainerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vContainerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vContainerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
