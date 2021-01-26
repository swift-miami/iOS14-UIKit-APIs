
import UIKit
import Combine
import SwiftUI

final class SplitViewController: UISplitViewController {
    @ObservedObject var modelController: ModelController
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        modelController = ModelController()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
    //        GithubAPI.fetch(.repositories)
    //            .sink(receiveCompletion: { completion in
    //                print(completion)
    //            }, receiveValue: { (repositories: [Repository]) in
    //
    //
    //            }).store(in: &cancellables)
        
    //        GithubAPI.fetch(.contributors("backtobasicsuikit"))
    //            .sink(receiveCompletion: { completion in
    //                print(completion)
    //            }, receiveValue: { (contributors: [Contributor]) in
    //                print(contributors)
    //
    //            }).store(in: &cancellables)
    }
}
