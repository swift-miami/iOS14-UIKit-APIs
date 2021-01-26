
import Foundation

/// Github Endpoint manager
enum GitHubEndpoints {
    // All Swift Miami Repositories
    case repositories
    
    // Collaborators for a given Repository
    case contributors(String)
    
    // Non-optional URL
    var url: URL {
        switch self {
        case .repositories:
            return URL(string: "https://api.github.com/orgs/swift-miami/repos")!
        case .contributors(let repository):
           
            let ur = URL(string: "https://api.github.com/repos/swift-miami/\(repository)/contributors")!
            print(ur)
            return ur
        }
    }
}
