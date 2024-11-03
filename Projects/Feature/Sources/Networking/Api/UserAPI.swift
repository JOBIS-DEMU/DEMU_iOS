import Foundation
import RxSwift
import RxCocoa
import Moya

enum UserAPI {
    case nickname(nickname: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.25.126:8080")!
    }

    var path: String {
        switch self {
        case .nickname:
            return "/user/nickname"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .patch
        }
    }

    var task: Moya.Task {
        switch self {
        case .nickname(let nickname):
            return .requestParameters(
                parameters: [
                    "nickname": nickname
                ], encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .nickname:
            return Header.accessToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
