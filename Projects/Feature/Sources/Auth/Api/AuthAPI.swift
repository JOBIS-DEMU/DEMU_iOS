import Foundation
import RxSwift
import RxCocoa
import Moya

enum AuthAPI {
    case signup(SignupInfo)
    case login(id: String, password: String)
    case loadUserInfo
    case loadUserPetition
    case idCheck(accountId: String)
    case passwordCheck(password: String)
    case userWithdrawal
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/public/signup"
        case .login:
            return "/public/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signup, .login:
            return .post
        case  .loadUserInfo, .loadUserPetition, .idCheck, .passwordCheck:
            return .get
        case .userWithdrawal:
            return .delete
        }
    }
    var task: Moya.Task {
        switch self {
        case .signup(let signupInfo):
            return .requestParameters(
                parameters: [
                    "accountId": signupInfo.accountId,
                    "password": signupInfo.password
                ],
                encoding: JSONEncoding.default
            )
        case .login(let id, let password):
            return .requestParameters(
                parameters: [
                    "accountId": id,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case .idCheck(let accountId):
            return .requestParameters(
                parameters: [
                    "accountId": accountId
                ],
                encoding: URLEncoding.queryString
            )
        case .passwordCheck(let password):
            return .requestParameters(
                parameters: [
                    "password": password
                ],
                encoding: URLEncoding.queryString
            )
        default:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        switch self {
        case .loadUserInfo, .loadUserPetition, .userWithdrawal:
            return Header.accessToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
