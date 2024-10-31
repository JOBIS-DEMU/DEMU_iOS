import Foundation
import RxSwift
import RxCocoa
import Moya

enum AuthAPI {
    case login(email: String, password: String)
    case signup(email: String, nickname: String, password: String)
    case refreshToken
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }

    var path: String {
        switch self {
        case .login:
            return "/public/signin"
        case .signup:
            return "/public/signup"
        case .refreshToken:
            return "/public/token/reissue"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
            
        case .signup(let email, let nickname, let password):
            return .requestParameters(
                parameters: [
                    "accountId": email,
                    "userName": nickname,
                    "password": password
                ], encoding: JSONEncoding.default)
        case .login(let email, let password):
            return .requestParameters(
                parameters: [
                    "accountId": email,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case .refreshToken:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .refreshToken:
            return Header.refreshToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
