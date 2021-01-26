
import Foundation
import UIKit
import Combine

enum GitHubEndpoints {
    static let repositories = URL(string: "https://api.github.com/orgs/swift-miami/repos")!
    
    static let collaborators = URL(string: "https://api.github.com/repos/swift-miami/algorithms-club/contributors")!
}

enum GithubError: Error {
    case URLSessionError(Error)
    
    case decodingError(Error)
}

enum GithubAPI {
    static func fetchRepositories(completion: @escaping (Result<Any, GithubError>) -> Void) {
        URLSession.shared.dataTask(with: GitHubEndpoints.repositories) { data, _, error in
            
            guard let data = data,
                error == nil else {
                
                let sessionError = error as! GithubError
                completion(.failure(.URLSessionError(sessionError)))
                
                return
            }
                        
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode([Repository].self, from: data)
                
                completion(.success(results))
            } catch {
                completion(.failure(GithubError.decodingError(error)))
                print(error)
            }
        }
        .resume()
    }
    
    static func fetchRepositories() -> AnyPublisher<[Repository], Error> {
        URLSession.shared.dataTaskPublisher(for: GitHubEndpoints.repositories)
            .map(\.data)
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fetchContributors(for repository: String) -> AnyPublisher<[Contributor], Error> {
        let url = URL(string: "https://api.github.com/repos/swift-miami/\(repository)/contributors")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Contributor].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
