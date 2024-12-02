import UIKit
import DesignSystem

final class ProductDetailsViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var vContainerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12.0
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 12, left: 20, bottom: 20, right: 20)
        return view
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .groupTableViewBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var nameLabel = ProductDetailsLabels()
    
    private lazy var descrLabel = ProductDetailsLabels()
    
    // MARK: - Properties
    
    private var viewModel: ProductDetailsViewModelProtocol
    
    // MARK: - Init
    
    init(viewModel: ProductDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationBar.apply(to: self,
                            title: "Detalhes",
                            rightButtonImage: nil,
                            rightButtonAction: nil)
        viewModel.refresh()
        
    }
}

extension ProductDetailsViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = Colors.Background.primaryBackground.uiColor
    }
    
    func buildViews() {
        [
            bannerImageView,
            nameLabel,
            descrLabel,
            UIView()
        ].forEach{
            vContainerStackView.addArrangedSubview($0)
        }
        
        [
            vContainerStackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            vContainerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vContainerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            vContainerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vContainerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            bannerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
    }
}

// MARK: - ProductDetailsViewModelDelegate
extension ProductDetailsViewController: ProductDetailsViewModelDelegate {
    
    func didUpdateInfo(imageURL: String, name: String, description: String) {
        if let url = URL(string: imageURL) {
            bannerImageView.downloadImageFrom(url: url)
        }
        
        nameLabel.title = "Name"
        nameLabel.subtitle = name
        
        descrLabel.title = "Description"
        descrLabel.subtitle = description
    }
}
