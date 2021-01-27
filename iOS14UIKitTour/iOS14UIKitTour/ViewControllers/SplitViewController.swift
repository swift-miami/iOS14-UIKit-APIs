
import UIKit
import Combine

final class SplitViewController: UISplitViewController {

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()

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

    override func viewDidLoad() {
        super.viewDidLoad()

        GithubAPI.fetch(.repositories)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] (_: [Repository]) in
               
                
            }).store(in: &cancellables)

        GithubAPI.fetch(.contributors("backtobasicsuikit"))
            .sink(receiveCompletion: { _ in
               
            }, receiveValue: { [weak self] (_: [Contributor]) in

            }).store(in: &cancellables)
    }


    // MARK: - Helpers

    private func setupChildViewControllers() {
        setViewController(sideBar, for: .primary)
        setViewController(detail, for: .secondary)
    }
}
