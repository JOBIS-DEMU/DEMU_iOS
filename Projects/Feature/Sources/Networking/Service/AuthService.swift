import Foundation
import UIKit
import RxSwift
import RxMoya
import Moya

final class AuthService {
    
    let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])
    
    func login(_ id: String, _ password: String) -> Single<networkingResult> {
        return provider.rx.request(.login(id: id, password: password))
            .filterSuccessfulStatusCodes()
            .map(AuthModel.self)
            .map{ response -> networkingResult in
                Token.accessToken = response.accessToken
                Token.refreshToken = response.refreshToken
                UserDefaults.standard.setValue(id, forKey: "userID")
                return .ok
            }
            .catch{[unowned self] in return .just(setNetworkError($0))}
    }
    
    func refreshToken() -> Single<networkingResult> {
        return provider.rx.request(.refreshToken)
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map{ response -> networkingResult in
                Token.accessToken = response.accessToken
                return .ok
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
 
    func signup(_ signup: SignupInfo) -> Single<networkingResult> {
        return provider.rx.request(.signup(signup))
            .filterSuccessfulStatusCodes()
            .map(AuthModel.self)
            .map{ response -> networkingResult in
                Token.accessToken = response.accessToken
                Token.refreshToken = response.refreshToken
                UserDefaults.standard.setValue(signup.accountId.value, forKey: "userID")
                return .createOk
            }
            .catch{[unowned self] in return .just(setNetworkError($0))}
    }
    
    func loadUserPetition() -> Single<([PetitionModel]?, networkingResult)> {
        return provider.rx.request(.loadUserPetition)
            .filterSuccessfulStatusCodes()
            .map([PetitionModel].self)
            .map{return ($0, .ok)}
            .catch{ error in
                print(error)
                return .just((nil, .fault))
            }
    }
    
    func setNetworkError(_ error: Error) -> networkingResult {
           print(error)
           print(error.localizedDescription)
           guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
           return (networkingResult(rawValue: status) ?? .fault)
   }
    
}
