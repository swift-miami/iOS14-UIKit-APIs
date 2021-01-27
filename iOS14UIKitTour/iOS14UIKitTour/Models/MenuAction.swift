
import UIKit

enum MenuAction {
    case delete
    case duplicate
    case share
    case star

    var title: String {
        switch self {
        case .delete:       return "Delete"
        case .duplicate:    return "Duplicate"
        case .share:        return "Share"
        case .star:         return "Star"
        }
    }

    var image: UIImage? {
        switch self {
        case .delete:       return UIImage(systemName: "trash")
        case .duplicate:    return UIImage(systemName: "doc.on.doc")
        case .share:        return UIImage(systemName: "square.and.arrow.up")
        case .star:         return UIImage(systemName: "star")
        }
    }
}

// MARK: - Contextual Menu Action Specific

extension MenuAction {
    var menuAttribute: UIMenuElement.Attributes? {
        switch self {
        case .delete:
            return .destructive

        case .duplicate,
             .share,
             .star:
            return nil
        }
    }
}

// MARK: - Swipe Action Specific

extension MenuAction {
    var swipeActionStyle: UIContextualAction.Style {
        switch self {
        case .delete:
            return .destructive

        case .duplicate,
             .share,
             .star:
            return .normal
        }
    }

    var swipeActionBackgroundColor: UIColor {
        switch self {
        case .delete:       return .systemRed
        case .duplicate:    return .systemRed
        case .share:        return .systemGray
        case .star:         return .systemYellow
        }
    }
}

extension UIContextMenuConfiguration {

    static func demo() -> UIContextMenuConfiguration {
        let delete = UIAction(action: .delete, handler: { })
        let star = UIAction(action: .star, handler: { })
        let duplicate = UIAction(action: .duplicate, handler: { })
        let share = UIAction(action: .share, handler: { })

        let config = UIContextMenuConfiguration(actions: [delete, star, share, duplicate])
        return config
    }
}

extension UISwipeActionsConfiguration {
    
    static func demo() -> UISwipeActionsConfiguration {
        let delete = UIContextualAction(action: .delete, handler: { })
        let star = UIContextualAction(action: .star, handler: { })

        let config = UISwipeActionsConfiguration(actions: [delete, star])
        return config
    }
}
