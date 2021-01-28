import UIKit
import Combine
import SDWebImage

final class DetailViewController: UIViewController {

    // MARK: - Type aliases

    typealias Item = Contributor
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()

    private lazy var layout: UICollectionViewCompositionalLayout = {
        return .init { _, environment in
            return .gridSection(with: .grid(environment))
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

    private func cellBuilder(collectionView: UICollectionView,
                     indexPath: IndexPath,
                     item: Contributor) -> UICollectionViewCell {

        let registation = ContributorCardCell.Registration { cell, indexPath, item in
            cell.configure(with: item)
        }

        return collectionView
            .dequeueConfiguredReusableCell(using: registation,
                                           for: indexPath,
                                           item: item)
    }

    private func setupNavBar() {
        navigationItem.title = "Contributors"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Data Helpers

    func fetchData(for repository: Repository) {
        let repoName = repository.name
        let pub: AnyPublisher<[Contributor], Error> = GithubAPI.fetch(.contributors(repoName))

        pub.sink(receiveCompletion: { _ in },
                 receiveValue: { [weak self] (contributors: [Contributor]) in
                    self?.applySnapshot(with: contributors)
                 })
            .store(in: &cancellables)
    }

    private func applySnapshot(with contributors: [Contributor]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(contributors, toSection: .main)

        diffableDataSource.apply(snapshot)
    }
}

// MARK: - Section

extension DetailViewController {
    enum Section {
        case main
    }
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        return .demo()
    }
}
