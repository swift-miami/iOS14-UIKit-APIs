import UIKit

enum System {

    enum Dimensions {
        static let gutter: CGFloat = 20
    }

    enum Layout {
        case grid

        var accessibilityMinWidth: CGFloat {
            switch self {
            case .grid: return 200
            }
        }

        var minWidth: CGFloat {
            switch self {
            case .grid: return 100
            }
        }


        var accessibilityMinHeight: CGFloat {
            switch self {
            case .grid: return 200
            }
        }

        var minHeight: CGFloat {
            switch self {
            case .grid: return 100
            }
        }

        var itemSpacing: CGFloat { Dimensions.gutter }

        func numberOfColumns(in environment: NSCollectionLayoutEnvironment) -> Int {
            return 0
        }

    }
}
