import UIKit

public protocol HorizontalMenuViewDelegate: AnyObject {
    func didSelectIndex(_ index: IndexPath)
}

public final class HorizontalMenuView: UIView {
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = .init(top: 0.0,
                                    left: 20,
                                    bottom: 0.0,
                                    right: 20)
        layout.itemSize = .init(width: 150.0, height: 150.0)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(HorizontalMenuCell.self,
                      forCellWithReuseIdentifier: HorizontalMenuCell.identifier)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    // MARK: - Properties
    
    private var urlList: [String] = []
    public weak var delegate: HorizontalMenuViewDelegate?
    
    // MARK: - Init
    public init() {
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
extension HorizontalMenuView: ViewConfiguration {
    public func configViews() {
        
    }
    
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

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HorizontalMenuView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectIndex(indexPath)
    }
}

extension HorizontalMenuView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urlList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalMenuCell.identifier,
                                                            for: indexPath) as? HorizontalMenuCell else {
            return .init()
        }
        let url = urlList[indexPath.row]
        cell.setImage(from: url)
        
        return cell
    }
}
