
import UIKit

final class SplitViewController: UISplitViewController {

    // MARK: - Properties

    let sideBar: SideBarViewController = {
        let sideBar = SideBarViewController()
        return sideBar
    }()

    let detail: DetailViewController = {
        let detail = DetailViewController()
        return detail
    }()

    // MARK: - Life Cycle

    override init(style: UISplitViewController.Style) {
        super.init(style: style)

        setupChildViewControllers()
    }

    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("Let's agree to disagree ✌🏻✌🏼✌🏽✌🏾✌🏿")
    }

    // MARK: - Helpers

    private func setupChildViewControllers() {
        setViewController(sideBar, for: .primary)
        setViewController(detail, for: .secondary)
    }
}
