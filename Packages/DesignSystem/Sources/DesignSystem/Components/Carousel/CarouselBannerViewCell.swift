import UIKit
import SDWebImage

public final class CarouselBannerViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CarouselBannerViewCell.self)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.0
        view.layer.applyShadow()
        
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
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
        backgroundImage.downloadImageFrom(url: url)
    }
}

extension CarouselBannerViewCell: ViewConfiguration {
    
    public func configViews() {
        contentView.backgroundColor = .white
    }
    
    public func buildViews() {
        containerView.addSubview(backgroundImage)
        
        contentView.addSubview(containerView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
