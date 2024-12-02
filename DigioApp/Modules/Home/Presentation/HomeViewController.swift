import UIKit
import DesignSystem

final class HomeViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var headerView = HomeHeaderView()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(HomeBannerViewCell.self, forCellReuseIdentifier: HomeBannerViewCell.identifier)
        view.register(HomeMenuViewCell.self, forCellReuseIdentifier: HomeMenuViewCell.identifier)
        view.separatorStyle = .none
        view.dataSource = self
        
        return view
    }()
    
    // MARK: - Properties
    
    private var viewModel: HomeViewModelProtocol
    
    // MARK: - Init
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refreshData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension HomeViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = Colors.Background.primaryBackground.uiColor
    }
    
    func buildViews() {
        [
            headerView,
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.itemAt(index: indexPath) else {
            return .init()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as? HomeViewCellProtocol else {
            return .init()
        }
        
        cell.setData(item)
        
        return cell
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func didLoadUserInformation(name: String) {
        DispatchQueue.main.async { [weak self] in
            self?.headerView.title = "Olá, \(name)"
        }
    }
    
    func didRefreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
