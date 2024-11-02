import Foundation
import RxSwift
import RxCocoa
import Moya

enum SearchAPI {
    case nameSearch(keyworld: Int)
}

extension SearchAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }
    
    
    var path: String {
        switch self {
        case .nameSearch:
            return "/search/title/{keyword}"
        }
    }
    
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .nameSearch:
            return .requestParameters(
                parameters: [
                    
                ], encoding: JSONEncoding.default)
            )
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
//            case .:
//                return Header.accessToken.header()
//            case .refreshToken:
//                return Header.refreshToken.header()
            default:
                return Header.tokenIsEmpty.header()
        }
    }
}
