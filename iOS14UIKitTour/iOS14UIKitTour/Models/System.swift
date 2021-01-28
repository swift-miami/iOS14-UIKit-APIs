import UIKit

enum System {

    enum Dimensions {
        static let regularGutter: CGFloat = 20
        static let compactGutter = Dimensions.regularGutter / 2

        static let regularVerticalMargin: CGFloat = 20
        static let regularHorizontalMargin: CGFloat = 20
        static let compactVerticalMargin = Dimensions.regularVerticalMargin / 2
        static let compactHorizontalMargin = Dimensions.regularVerticalMargin / 2

        static let contributorCellImageSize: CGFloat = 96
    }

    enum Layout {
        case grid(NSCollectionLayoutEnvironment)

        var accessibilityMinWidth: CGFloat {
            switch self {
            case .grid: return minWidth * 2
            }
        }

        var minWidth: CGFloat {
            switch self {
            case .grid: return minHeight * 2
            }
        }

        var accessibilityMinHeight: CGFloat {
            switch self {
            case .grid: return minHeight * 2
            }
        }

        var minHeight: CGFloat {
            switch self {
            case .grid:
                return Dimensions.contributorCellImageSize + itemSpacing * 4
            }
        }

        var itemSpacing: CGFloat {
            switch self {
            case .grid(let environment):
                return environment.isHorizontallyCompact
                    ? Dimensions.compactGutter
                    : Dimensions.regularGutter
            }
        }

        var contentInsets: NSDirectionalEdgeInsets {
            switch self {
            case .grid(let environment):
                let verticalInset = environment.isVerticallyCompact
                    ? Dimensions.compactVerticalMargin
                    : Dimensions.regularVerticalMargin

                let horizontalInset = environment.isHorizontallyCompact
                    ? Dimensions.compactHorizontalMargin
                    : Dimensions.regularHorizontalMargin

                return .init(top: verticalInset,
                             leading: horizontalInset,
                             bottom: verticalInset,
                             trailing: horizontalInset)
            }
        }

        var minCellWidth: CGFloat {
            switch self {
            case .grid(let environment):
                return environment.isAccessibilityCategorySize
                    ? accessibilityMinWidth
                    : minWidth
            }
        }

        var cellHeight: NSCollectionLayoutDimension {
            switch self {
            case .grid(let environment):
                return environment.isAccessibilityCategorySize
                    ? .estimated(accessibilityMinHeight)
                    : .absolute(minHeight)
            }
        }

        var numberOfColumns: Int {
            switch self {
            case .grid(let environment):
                let contentWidth = environment.container.contentSize.width
                let numberOfItemsThatFit = max(1, Int(contentWidth / minCellWidth))
                return numberOfItemsThatFit
            }
        }

    }
}
