import UIKit
import DesignSystem

final class ProductDetailsLabels: UIStackView {
    
    // MARK: - UI
    
    private lazy var titleLabel = UILabel.build(size: .title2,
                                                weight: .bold,
                                                textColor: .darkGray,
                                                numberOfLines: 1)
    private lazy var subtitleLabel = UILabel.build(size: .title3,
                                                   weight: .regular,
                                                   textColor: .darkGray)

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewConfiguration
extension ProductDetailsLabels: ViewConfiguration {
    func configViews() {
        axis = .vertical
    }
    
    func buildViews() {
        [
            titleLabel, subtitleLabel
        ].forEach {
            addArrangedSubview($0)
        }
    }
    
    func setupConstraints() { }
}
