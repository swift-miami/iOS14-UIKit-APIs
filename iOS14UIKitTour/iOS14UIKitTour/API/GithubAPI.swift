//
//  WebAPI.swift
//  iOS14UIKitTour
//

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
    
    // static func fetchRepositories() -> AnyPublisher<[Repository], GithubError> {
    //     return URLSession.shared.dataTaskPublisher(for: GitHubEndpoint.baseUrl).eraseToAnyPublisher()
    // }
}
