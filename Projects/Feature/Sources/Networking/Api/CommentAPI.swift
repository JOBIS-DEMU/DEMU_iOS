import Foundation
import RxSwift
import RxCocoa
import Moya

enum CommentAPI {
    case commentCreat(content: String)
    case commentDelete(commentId: Int)
}


extension CommentAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }
    
    
    var path: String {
        switch self {
        case .commentCreat(let postId):
            return "/comment/create/{post-id}"
        case .commentDelete(let commentId):
            return "/comment/delete/{comment-id}"
        }
    }
    
    
    
    var method: Moya.Method {
        switch self {
        case .commentDelete:
            return .delete
        default:
            return .post
        }
    }
 
    
    var task: Moya.Task {
        switch self {
        case .commentCreat(let content):
            return .requestParameters(
                parameters: [
                    "content": content
                ], encoding: JSONEncoding.default
            )
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .commentCreat, .commentDelete:
            return Header.accessToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
