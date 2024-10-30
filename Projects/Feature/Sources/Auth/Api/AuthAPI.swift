import Foundation
import RxSwift
import RxCocoa
import Moya

enum AuthAPI {
    case login(email: String, password: String)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/public/signin"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    var task: Moya.Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(
                parameters: [
                    "accountId": email,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        }
    }
    var headers: [String : String]? {
        return Header.tokenIsEmpty.header()
    }
}
