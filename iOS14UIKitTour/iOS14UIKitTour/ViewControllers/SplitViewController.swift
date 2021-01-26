
import UIKit
import Combine

//final class SplitViewController: UISplitViewController {
//
//    private var cancellables = Set<AnyCancellable>()
//
//    override func viewDidLoad() {
////        GithubAPI.fetchRepositories { result in
////            switch result {
////            case .success(let success):
////                print(success)
////
////            case .failure(let error):
////                print(error)
////            }
////        }
//
//        GithubAPI.fetchRepositories()
//            .sink { (l) in
//                print(l)
//            } receiveValue: { (repos) in
//                print(repos)
//                print("We did it!")
//            }
//            .store(in: &cancellables)
//
//        GithubAPI.fetchContributors(for: "BackToBasicsUIKit")
//            .sink { (l) in
//                print(l)
//            } receiveValue: { (repos) in
//                print(repos)
//                print("We did it!")
//            }
//            .store(in: &cancellables)
//    }
//}

final class SplitViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    private enum Row: Int, CaseIterable {
        case firstRow, secondRow, thirdRow

        static var count: Int { Row.allCases.count }

        var title: String {
            switch self {
            case .firstRow:       return "First Row"
            case .secondRow: return "Second Row"
            case .thirdRow:    return "Third Row"
            }
        }

        var image: UIImage? {
            switch self {
            case .firstRow:       return UIImage(systemName: "flowchart.fill")
            case .secondRow: return UIImage(systemName: "square.split.1x2.fill")
            case .thirdRow:    return UIImage(systemName: "rectangle.3.offgrid.fill")
            }
        }

        var tintColor: UIColor? {
            switch self {
            case .firstRow:       return .systemPurple
            case .secondRow: return .systemBlue
            case .thirdRow:    return .systemOrange
            }
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        title = "iOS 14 Tour"
        collectionView.backgroundColor = .systemBackground
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { context in
            self.collectionViewLayout.invalidateLayout()

        }, completion: nil)
    }

    // MARK: - Helpers
    
    private func setupCollectionView() {
        collectionView.register(ListCollectionCell.self, forCellWithReuseIdentifier: "listcell")
    }

    // MARK: - Table view data source
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        Row.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: ListCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "listcell", for: indexPath) as! ListCollectionCell

        let row = Row(rawValue: indexPath.row)

        cell.configure(with: row?.title,
                       image: row?.image,
                       tintColor: row?.tintColor)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {

        guard let row = Row(rawValue: indexPath.row) else { return }

        let viewController: UIViewController

        switch row {
        case .firstRow:    viewController = UIViewController()
        case .secondRow:   viewController = UIViewController()
        case .thirdRow:    viewController = UIViewController()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.width,
                      height: 60)
    }
}


final class ListCollectionCell: UICollectionViewCell {

    // MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        return separator
    }()

    private let disclosureView: UIImageView = {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        let discloureIcon = UIImage(systemName: "chevron.right",
                                    withConfiguration: config)
        let imageView = UIImageView(image: discloureIcon)
        imageView.tintColor = .separator
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()


    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Nope. ⛔️")
    }

    // MARK: - Helpers
    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(disclosureView)
        contentView.addSubview(separator)

        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: guide.leadingAnchor,
                                               multiplier: 2),

            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor,
                                                multiplier: 2),
            titleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: disclosureView.trailingAnchor,
                                                 multiplier: 2),

            disclosureView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            disclosureView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            separator.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Interface
    func configure(with title: String?,
                   image: UIImage?,
                   tintColor: UIColor? = .label) {

        titleLabel.text = title
        titleLabel.textColor = tintColor
        imageView.image = image
        imageView.tintColor = tintColor
    }
}
