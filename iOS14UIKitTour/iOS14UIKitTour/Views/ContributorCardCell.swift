import UIKit

final class ContributorCardCell: UICollectionViewCell {

    typealias Registration = UICollectionView.CellRegistration<ContributorCardCell, Contributor>

    // MARK: - Properties

    private enum Constants {
        static let cornerRadius: CGFloat = 16
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()

    private let accountLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()

    private let contributionsLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemBlue
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func setupLayout() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.cornerCurve = .continuous
        contentView.layer.masksToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        layer.cornerCurve = .continuous
        layer.masksToBounds = true

        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(accountLabel)
        stackView.addArrangedSubview(contributionsLabel)


        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: System.Dimensions.contributorCellImageSize),
            imageView.heightAnchor.constraint(equalToConstant: System.Dimensions.contributorCellImageSize),
            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: guide.leadingAnchor,
                                               multiplier: 1),
            imageView.topAnchor.constraint(greaterThanOrEqualTo: guide.topAnchor),
            imageView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),

            stackView.topAnchor.constraint(greaterThanOrEqualTo: guide.topAnchor),
            stackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor,
                                               multiplier: 2),
            guide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor,
                                            multiplier: 2)
        ])
    }

    // MARK: - API

    func configure(with contributor: Contributor) {
        imageView.sd_setImage(with: contributor.imageURL, completed: nil)

        nameLabel.text = contributor.userName
        accountLabel.text = contributor.accountURL
        contributionsLabel.text = contributor.contributionsLabelText
    }
}
