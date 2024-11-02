import Foundation
import RxSwift
import RxCocoa
import Moya

enum PostAPI {
    case postCreate(title: String, content: String, major: String)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }
    
    var path: String {
        switch self {
        case .postCreate:
            return "/post/create"
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
        case .postCreate(let title, let content, let major):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "content": content,
                    "major": major
                ], encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        switch self {
        case .postCreate:
            return Header.accessToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
