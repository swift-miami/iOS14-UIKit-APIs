import Foundation

struct Contributor: Hashable {
    let id: Int
    let userName: String
    let avatarURL: String
    let accountURL: String
    var contributions: Int?
}

// MARK: - Codable

extension Contributor: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case avatarURL = "avatar_url"
        case accountURL = "html_url"
        case contributions
    }
}

// MARK: - UI Helpers
extension Contributor {
    var imageURL: URL? {
        return URL(string: avatarURL)
    }

    var contributionsLabelText: String? {
        guard let count = contributions else { return nil }
        return "\(count) CONTRIBUTIONS"
    }
}
