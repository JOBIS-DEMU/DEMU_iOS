import Foundation
import RxSwift
import RxCocoa
import Moya

enum SearchAPI {
    case titleSearch(keyword: Int)
    case majorSearch(major: Int)
}

extension SearchAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.37.219.136:8080")!
    }

    var path: String {
        switch self {
        case .titleSearch(let keyword):
            return "/search/title/\(keyword)"
        case .majorSearch(let major):
            return "public/search/major/\(major)"
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
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
            default:
                return Header.tokenIsEmpty.header()
        }
    }
}
