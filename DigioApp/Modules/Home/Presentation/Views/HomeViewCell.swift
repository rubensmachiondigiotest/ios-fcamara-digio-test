import UIKit
import DesignSystem

protocol HomeViewCellProtocol: UITableViewCell {
    static var identifier: String { get }
    
    func setData(_ data: HomeRepositoryResponse, selectItem: @escaping ((Int) -> Void))
}

extension HomeViewCellProtocol {
    static var identifier: String {
        return ""
    }
}

open class HomeViewCell: UITableViewCell, HomeViewCellProtocol {
    
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
    
    private lazy var listView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var title: String? {
        didSet {
            titleSectionLabel.text = title
        }
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
    
    func addListView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        listView.addSubview(view)
        
        view.topAnchor.constraint(equalTo: listView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: listView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: listView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: listView.trailingAnchor).isActive = true
    }
    
    open func setData(_ data: HomeRepositoryResponse, selectItem: @escaping ((Int) -> Void)) { }
}

// MARK: - ViewConfiguration
extension HomeViewCell: ViewConfiguration {
    public func configViews() {
        contentView.backgroundColor = Colors.Background.primaryBackground.uiColor
    }
    
    public func buildViews() {
        titleContainerStack.addArrangedSubview(titleSectionLabel)
        
        vContainerStack.addArrangedSubview(titleContainerStack)
        vContainerStack.addArrangedSubview(listView)
        
        contentView.addSubview(vContainerStack)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            vContainerStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vContainerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vContainerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vContainerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            listView.heightAnchor.constraint(equalToConstant: 180.0)
        ])
    }
}
