import UIKit

public final class HomeHeaderView: UIStackView {
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView(image: Images.Logo.navigationBarLogo.uiImage)
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var titleLabel = UILabel.build(size: .title3,
                                                weight: .bold,
                                                textColor: Colors.Neutral.primaryTextColor.uiColor)
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public init(title: String? = nil) {
        self.title = title
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderView: ViewConfiguration {
    public func configViews() {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 12.0, left: 20.0, bottom: 12.0, right: 20.0)
        spacing = 12
    }
    
    public func buildViews() {
        [
            logoImage,
            titleLabel,
            .init() // Space
        ].forEach {
            addArrangedSubview($0)
        }
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 40.0),
            logoImage.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}
