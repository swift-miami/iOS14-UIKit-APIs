import UIKit
import Combine

final class SideBarViewController: UIViewController {

    // MARK: - Type aliases

    typealias Item = Repository
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item>

    // MARK: - Properties

    var onRepoSelection: (Repository) -> Void = { _ in }

    private var cancellables = Set<AnyCancellable>()

    private lazy var barButton: UIBarButtonItem = {
        let action = UIAction { [weak self] _ in
            self?.showAlert()
        }
        let barButton = UIBarButtonItem(systemItem: .action,
                                        primaryAction: action,
                                        menu: .demo())

        return barButton
    }()

    private lazy var layout: UICollectionViewLayout = {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)

        config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            .demo()
        }
        config.leadingSwipeActionsConfigurationProvider =  { [weak self] indexPath in
            .demo()
        }

        return UICollectionViewCompositionalLayout { section, environment in
            config.headerMode = .none
            return NSCollectionLayoutSection.list(using: config,
                                                  layoutEnvironment: environment)
        }
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.backgroundColor = .secondarySystemBackground
        return collectionView
    }()

    private lazy var diffableDataSource: DiffableDataSource = {
        let diffableDataSource = DiffableDataSource(collectionView: collectionView) {
            [weak self] collectionView, indexPath, item -> UICollectionViewCell? in

            return self?.cellBuilder(collectionView: collectionView,
                                     indexPath: indexPath,
                                     item: item)
        }

        return diffableDataSource
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupNavBar()
    }

    // MARK: - View Helpers

    private func setupLayout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupNavBar() {
        navigationItem.title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = barButton
    }

    private func cellBuilder(collectionView: UICollectionView,
                             indexPath: IndexPath,
                             item: Item) -> UICollectionViewCell {


        let registation = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            content.secondaryText = item.description
            content.secondaryTextProperties.color = .secondaryLabel
            content.secondaryTextProperties.numberOfLines = 1
            cell.contentConfiguration = content
            cell.accessories = [.outlineDisclosure()]
        }

        return collectionView
            .dequeueConfiguredReusableCell(using: registation,
                                           for: indexPath,
                                           item: item)
    }

    private func showAlert() {
        let alert = UIAlertController(title: "👋🏻👋🏼👋🏽👋🏾👋🏿",
                                      message: "Hello there Miami Swifters. You're awesome!",
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Go Away", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: - Data Helpers

    func fetchData() {
        let pub: AnyPublisher<[Item], Error> = GithubAPI.fetch(.repositories)

        pub.sink(receiveCompletion: { completion in },
                 receiveValue: { [weak self] (repos: [Item]) in
                    self?.applySnapshot(with: repos)
                 })
            .store(in: &cancellables)
    }

    private func applySnapshot(with repos: [Item]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(repos, toSection: .main)

        diffableDataSource.apply(snapshot) { [weak self] in
            guard let repo = repos.first else { return }
            self?.onRepoSelection(repo)
            self?.collectionView.selectItem(at: IndexPath(item: 0, section: 0),
                                            animated: false,
                                            scrollPosition: [])
        }
    }
}

// MARK: - Section

extension SideBarViewController {
    enum Section {
        case main
    }
}

// MARK: - UICollectionViewDelegate

extension SideBarViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        guard let item = diffableDataSource.itemIdentifier(for: indexPath) else { return }

        onRepoSelection(item)
    }

    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        return .demo()
    }
}
