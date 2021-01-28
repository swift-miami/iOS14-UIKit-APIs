import Foundation

struct Repository: Hashable {
    let id: Int
    let name: String
    let user: Contributor
    let contributorsURL: String
    let updatedDate: String
    let description: String?
}

// MARK: - Codable

extension Repository: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case user = "owner"
        case contributorsURL = "contributors_url"
        case updatedDate = "updated_at"
        case description
    }
}
