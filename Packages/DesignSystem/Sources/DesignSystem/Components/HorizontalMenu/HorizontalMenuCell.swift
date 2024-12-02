import UIKit
import SDWebImage

public final class HorizontalMenuCell: UICollectionViewCell {
    
    static let identifier = String(describing: HorizontalMenuCell.self)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.0
        view.layer.applyShadow()
        view.backgroundColor = Colors.Background.primaryBackground.uiColor
        
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12.0
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(from url: String) {
        guard let url = URL(string: url) else {
            return
        }
        iconImageView.downloadImageFrom(url: url)
    }
}

extension HorizontalMenuCell: ViewConfiguration {
    
    public func configViews() {
        contentView.backgroundColor = Colors.Background.primaryBackground.uiColor
    }
    
    public func buildViews() {
        containerView.addSubview(iconImageView)
        
        contentView.addSubview(containerView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])
    }
}
