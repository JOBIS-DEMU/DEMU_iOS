import Foundation
import SwiftKeychainWrapper

struct Token {
    static var localRefreshToken: String?
    static var localAccessToken: String?
    
    static var refreshToken: String? {
        get {
            localRefreshToken = KeychainWrapper.standard.string(forKey: "refreshToken")
            return localRefreshToken
        }
        set(newToken) {
            KeychainWrapper.standard.set(newToken ?? "nil", forKey: "refreshToken")
            localRefreshToken = newToken
        }
    }
    static var accessToken: String? {
        get {
            localAccessToken = KeychainWrapper.standard.string(forKey: "accessToken")

            return localAccessToken
        }
        set(newToken) {
            KeychainWrapper.standard.set(newToken ?? "nil", forKey: "accessToken")
            localAccessToken = newToken
        }
    }
    static func removeToken() {
        self.refreshToken = nil
        self.accessToken = nil
    }
}

enum Header {
    case refreshToken, accessToken, tokenIsEmpty
    func header() -> [String: String]? {
        guard let refreshToken = Token.refreshToken,
              refreshToken != "nil" else {
            return ["Content-Type": "application/json"]
        }
        guard let accessToken = Token.accessToken,
              accessToken != "nil" else {
            return ["Content-Type": "application/json"]
        }
        switch self {
            case .refreshToken:
                return ["Authorization": "Header " + refreshToken, "Content-Type": "application/json"]
            case .accessToken:
                return ["Authorization": "Bearer " + accessToken, "Content-Type": "application/json"]
            case .tokenIsEmpty:
                return ["Content-Type": "application/json"]
        }
    }
}
