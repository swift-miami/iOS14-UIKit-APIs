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

    static func gridSection(with layoutConfig: System.Layout) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: layoutConfig.cellHeight)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: layoutConfig.numberOfColumns)
        group.interItemSpacing = .fixed(layoutConfig.itemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = layoutConfig.itemSpacing
        section.contentInsets = layoutConfig.contentInsets

        return section
    }
}
