import Foundation
import RxSwift
import RxCocoa
import Moya

enum AuthAPI {
    case signup(SignupInfo)
    case login(id: String, password: String)

}


extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "3.37.219.136:8080")!
    }
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
case .
default:
    return .post
    
}
