
struct Repository: Codable {
    let name: String
    let user: User
    let contributorsURL: String
    let updatedDate: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case user = "owner"
        case contributorsURL = "contributors_url"
        case updatedDate = "updated_at"
    }
}
