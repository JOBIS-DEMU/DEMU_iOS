import Foundation
import RxSwift
import RxCocoa
import Moya

enum PostAPI {
    case postCreate(title: String, content: String, major: String)
    case postFix(content: String, title: String, major: String, postId: Int)
    case postSuggestion(postId: Int)
    case postCheck(postId: Int)
    case postUserCheck
    case postDelete(postId: Int)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }
    
    var path: String {
        switch self {
        case .postCreate:
            return "/post/create"
        case .postFix(let postId):
            return "/post/update/\(postId)"
        case .postSuggestion(let postId):
            return "/post/recommend/\(postId)"
        case .postCheck(let postId):
            return "/post/get/\(postId)"
        case .postUserCheck:
            return "/post/get/my-posts"
        case .postDelete:
            return "/post/delete/{post-id}"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postFix:
            return .patch
        case .postCheck, .postUserCheck:
            return .get
        case .postDelete:
            return .delete
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
        case .postCreate, .postFix, .postSuggestion, .postCheck, .postUserCheck, .postDelete:
            return Header.accessToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
