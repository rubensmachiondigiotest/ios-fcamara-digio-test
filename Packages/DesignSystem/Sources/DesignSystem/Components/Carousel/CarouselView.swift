import UIKit

public protocol CarouselViewDelegate: AnyObject {
    func didSelectIndex(_ index: IndexPath)
}

public final class CarouselView: UIView {
    
    // MARK: - UI
    
    private let centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout = {
        let flowLayout = CenteredCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
    
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CarouselBannerViewCell.self,
                      forCellWithReuseIdentifier: CarouselBannerViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self

        centeredCollectionViewFlowLayout.itemSize = self.itemSize

        return view
    }()
    
    // MARK: - Properties
    
    var itemSize: CGSize
    private var urlList: [String] = []
    
    public weak var delegate: CarouselViewDelegate?
    
    public init(itemSize: CGSize) {
        self.itemSize = itemSize
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setData(urlList: [String]) {
        self.urlList = urlList
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

// MARK: - ViewConfiguration
extension CarouselView: ViewConfiguration {
    public func configViews() { }
    
    public func buildViews() {
        [
            collectionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource,
extension CarouselView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectIndex(indexPath)
    }
}

extension CarouselView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urlList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselBannerViewCell.identifier,
                                                            for: indexPath) as? CarouselBannerViewCell else {
            return .init()
        }
        let url = urlList[indexPath.row]
        cell.setImage(from: url)
        
        return cell
    }
}
