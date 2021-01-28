
import UIKit

// MARK: - UIAction

extension UIAction {

    /// Convenience init to build a UIAction from a `MenuAction`
    /// to be used in a `UIContextMenuConfiguration`.
    convenience init(action: MenuAction,
                     handler: @escaping Block) {

        let actionHandler: UIActionHandler = { _ in handler() }

        self.init(title: action.title,
                  image: action.image,
                  handler: actionHandler)

        if let attribute = action.menuAttribute {
            self.attributes = attribute
        }
    }
}

// MARK: - UIMenu

extension UIMenu {

    convenience init(actions: [UIAction]) {
        self.init(title: "", children: actions)
    }
}

// MARK: - UIContextMenuConfiguration

extension UIContextMenuConfiguration {

    convenience init(actions: [UIAction]) {

        self.init(identifier: nil,
                  previewProvider: nil) { _ in
            return UIMenu(title: "", children: actions)
        }
    }
}
