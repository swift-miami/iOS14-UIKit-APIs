import UIKit

// MARK: - NSCollectionLayoutSection

extension NSCollectionLayoutEnvironment {

    var isHorizontallyCompact: Bool {
        return traitCollection.horizontalSizeClass == .compact
    }

    var isVerticallyCompact: Bool {
        return traitCollection.verticalSizeClass == .compact
    }

    var isAccessibilityCategorySize: Bool {
        return traitCollection.preferredContentSizeCategory.isAccessibilityCategory
    }
}

// MARK: - NSCollectionLayoutSection

extension NSCollectionLayoutSection {

    static func gridCollection(minimumItemWidth: CGFloat,
                               itemHeight: NSCollectionLayoutDimension,
                               itemSpacing: CGFloat,
                               contentWidth: CGFloat) -> NSCollectionLayoutSection {

        let numberOfItemsThatFit = max(1, Int(contentWidth / minimumItemWidth))

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: itemHeight)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: numberOfItemsThatFit)
        group.interItemSpacing = .fixed(itemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = itemSpacing

        return section
    }

    static func gridSection(configuration: System.Layout,
                            environment: NSCollectionLayoutEnvironment,
                            contentInsets: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection {

        let contentWidth = environment.container.contentSize.width
        let isCompact = environment.isHorizontallyCompact
            || environment.isAccessibilityCategorySize

        let minCellWidth = environment.isAccessibilityCategorySize
            ? configuration.accessibilityMinWidth
            : configuration.minWidth

        let cardHeight: NSCollectionLayoutDimension = environment.isAccessibilityCategorySize
            ? .estimated(configuration.accessibilityMinHeight)
            : .absolute(configuration.minHeight)

        let section = NSCollectionLayoutSection
            .gridCollection(minimumItemWidth: minCellWidth,
                            itemHeight: cardHeight,
                            itemSpacing: configuration.itemSpacing,
                            contentWidth: contentWidth)

        let leading = isCompact
            ? contentInsets.leading / 2
            : contentInsets.leading

        let trailing = isCompact
            ? contentInsets.trailing / 2
            : contentInsets.trailing
        section.contentInsets = contentInsets
        section.contentInsets.leading = leading
        section.contentInsets.trailing = trailing

        return section
    }

    static func multiColumnSection(config: System.Layout,
                                   environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(config.minHeight))
        
        let columns = config.numberOfColumns(in: environment)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: columns)
        group.interItemSpacing = .fixed(config.itemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
