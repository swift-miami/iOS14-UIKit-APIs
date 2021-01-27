import UIKit

extension UIContextualAction {

    /// Convenience init to build a UIAction from a `MenuAction`
    /// to be used in a `UISwipeActionsConfiguration`.
    convenience init(action: MenuAction,
                     handler: @escaping Block) {

        let handler: Handler = { _,_, completion in
            handler()
            completion(true)
        }

        self.init(style: action.swipeActionStyle,
                  title: action.title,
                  handler: handler)
        self.image = action.image
        self.backgroundColor = action.swipeActionBackgroundColor
    }
}
