
import UIKit

final class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        GithubAPI.fetchRepositories { result in 
            switch result {
            case .success(let success):
                print(success)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
