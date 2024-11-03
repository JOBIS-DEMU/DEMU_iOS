import Foundation
import RxSwift
import RxCocoa
import Moya

enum AuthAPI {
    case login(email: String, password: String)
    case signup(email: String, nickname: String, password: String)
    case emailsend(email: String)
    case checkPwd(password: String)
    case refreshToken
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://52.78.215.162:8080")!
    }

    var path: String {
        switch self {
        case .login:
            return "/public/signin"
        case .signup:
            return "/public/signup"
        case .emailsend(let email):
            return "/public/password/find/\(email)@dsm.hs.kr"
        case .checkPwd:
            return "/password/validate"
        case .refreshToken:
            return "/public/token/reissue"
        }
    }

    var method: Moya.Method {
        switch self {
        case .emailsend:
            return .get
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
                    "nickname": nickname,
                    "password": password
                ], encoding: JSONEncoding.default
            )
        case .login(let email, let password):
            return .requestParameters(
                parameters: [
                    "accountId": email,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case .checkPwd(password: let password):
            return .requestParameters(
                parameters: [
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .refreshToken:
            return Header.refreshToken.header()
        case .checkPwd:
            return Header.accessToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
