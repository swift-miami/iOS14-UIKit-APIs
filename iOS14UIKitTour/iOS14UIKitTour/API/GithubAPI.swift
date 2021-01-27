
import Foundation
import Combine

enum GithubAPI {
    /// Returns a publisher that performs a GET request.
    ///
    /// - Parameters:
    ///     - endpoint: the GithubEndpoint enum case which maps to the appropriate URL.
    static func fetch<T: Decodable>(_ endpoint: GitHubEndpoints) -> AnyPublisher<[T], Error> {
        return URLSession.shared.dataTaskPublisher(for: endpoint.url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [T].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
