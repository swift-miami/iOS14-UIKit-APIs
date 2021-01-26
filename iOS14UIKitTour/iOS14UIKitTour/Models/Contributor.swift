
struct Contributor: Codable {
    let userName: String
    let avatarURL: String
    let accountURL: String
    let contributions: Int
   
    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case avatarURL = "avatar_url"
        case accountURL = "html_url"
        case contributions
    }
}
