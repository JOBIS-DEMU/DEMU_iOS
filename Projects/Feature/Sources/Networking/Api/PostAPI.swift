import Foundation
import RxSwift
import RxCocoa
import Moya

enum PostAPI {
    case postCreate(title: String, content: String, major: String)
    case postFix(content: String, title: String, major: String)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }
    
    var path: String {
        switch self {
        case .postCreate:
            return "/post/create"
        case .postFix:
            return "/post/update/{post-id}"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postFix:
            return .patch
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
        case .postCreate, .postFix:
            return Header.accessToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
