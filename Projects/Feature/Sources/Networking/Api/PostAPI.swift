import Foundation
import RxSwift
import RxCocoa
import Moya

enum PostAPI {
    case postCreate(title : String,content : String,major : Enum)
    
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }
    
    var path: String {
        switch self {
        case .postCreate
            return "/post/create"
        }
    }
    
    
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
}
