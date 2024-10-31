import Foundation

struct AuthModel: Codable {
    let accessToken: String?
    let refreshToken: String?
    let role: String?
    let userName: String?
}
