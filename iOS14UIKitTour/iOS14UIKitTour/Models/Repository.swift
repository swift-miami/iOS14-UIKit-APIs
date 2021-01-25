
struct Repository: Codable {
    let name: String
    let id: String
    let contributors: [Contributor]
}
