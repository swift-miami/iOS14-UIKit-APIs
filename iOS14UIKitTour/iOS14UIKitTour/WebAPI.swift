//
//  WebAPI.swift
//  iOS14UIKitTour
//

import Foundation
import UIKit

enum GitHubEndpoint {
//    static let scheme = "https"
//
//    static let host = "https://api.github.com"
//
//    static let urlPath = ""
    
    static let baseUrl = URL(string: "https://api.github.com/orgs/swift-miami/repos")!
    
    static let collaboratorsURL = "https://api.github.com/repos/swift-miami/algorithms-club/contributors"
}

enum GithubError: Error {
    case error
}

enum GithubAPI {
    static func fetchRepositories(completion: @escaping (Result<Any, GithubError>) -> Void) {
        URLSession.shared.dataTask(with: GitHubEndpoint.baseUrl) { data, _, _ in
            
            guard let data = data else { fatalError() }
            
            print(String(data: data, encoding: .utf8))
            
            do {
                let results = try JSONDecoder().decode([GithubResponseElement].self, from: data)
                
                
              //  print(results)
                //completion(.success(results.owner))
                //completion(.success(results))
                completion(.success(results))
            } catch {
                print("EERRRRRRRRROR")
                completion(.failure(GithubError.error))
                print(error)
            }
        }
        .resume()
    }
}

//struct GithubResponse: Decodable {
//    let repositoryName: String
//    let repositories: [Repository]
//
//    enum CodingKeys: String, CodingKey {
//        case repositoryName = "name"
//        case repositories = "owner"
//    }
//}

// MARK: - GithubResponseElement
struct GithubResponseElement: Codable {
    let name: String
    let owner: Owner
    let htmlURL: String
    let githubResponseDescription: String?
    let fork: Bool
    let url: String
    let forksURL: String
    let keysURL, collaboratorsURL: String
    let teamsURL, hooksURL: String
    let issueEventsURL: String
    let eventsURL: String
    let assigneesURL, branchesURL: String
    let tagsURL: String
    let blobsURL, gitTagsURL, gitRefsURL, treesURL: String
    let statusesURL: String
    let languagesURL, stargazersURL, contributorsURL, subscribersURL: String
    let subscriptionURL: String
    let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String
    let contentsURL, compareURL: String
    let mergesURL: String
    let archiveURL: String
    let downloadsURL: String
    let issuesURL, pullsURL, milestonesURL, notificationsURL: String
    let labelsURL, releasesURL: String
    let deploymentsURL: String
    let gitURL, sshURL: String
    let cloneURL: String
    let svnURL: String
    let homepage: String?
    let size, stargazersCount, watchersCount: Int
    let language: Language?
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool
    let hasPages: Bool
    let forksCount: Int
    let mirrorURL: JSONNull?
    let archived, disabled: Bool
    let openIssuesCount: Int
    let license: License?
    let forks, openIssues, watchers: Int
    let defaultBranch: DefaultBranch
    let permissions: Permissions

    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case htmlURL = "html_url"
        case githubResponseDescription = "description"
        case fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
    
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case license, forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
        case permissions
    }
}

enum DefaultBranch: String, Codable {
    case main = "main"
    case master = "master"
}

enum Language: String, Codable {
    case ruby = "Ruby"
    case swift = "Swift"
}

// MARK: - License
struct License: Codable {
    let key, name, spdxID: String
    let url: String
    let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: Login
    let id: Int
    let nodeID: NodeID
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL: FollowingURL
    let gistsURL: GistsURL
    let starredURL: StarredURL
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: EventsURL
    let receivedEventsURL: String
    let type: TypeEnum
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

enum EventsURL: String, Codable {
    case httpsAPIGithubCOMUsersSwiftMiamiEventsPrivacy = "https://api.github.com/users/swift-miami/events{/privacy}"
}

enum FollowingURL: String, Codable {
    case httpsAPIGithubCOMUsersSwiftMiamiFollowingOtherUser = "https://api.github.com/users/swift-miami/following{/other_user}"
}

enum GistsURL: String, Codable {
    case httpsAPIGithubCOMUsersSwiftMiamiGistsGistID = "https://api.github.com/users/swift-miami/gists{/gist_id}"
}

enum Login: String, Codable {
    case swiftMiami = "swift-miami"
}

enum NodeID: String, Codable {
    case mdEyOk9YZ2FuaXphdGlvbjQ3NTY5MDk3 = "MDEyOk9yZ2FuaXphdGlvbjQ3NTY5MDk3"
}

enum StarredURL: String, Codable {
    case httpsAPIGithubCOMUsersSwiftMiamiStarredOwnerRepo = "https://api.github.com/users/swift-miami/starred{/owner}{/repo}"
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
}

// MARK: - Permissions
struct Permissions: Codable {
    let admin, push, pull: Bool
}

typealias GithubResponse = [GithubResponseElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
