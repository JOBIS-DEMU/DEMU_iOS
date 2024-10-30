import Foundation
import UIKit
import RxSwift
import Moya

final class AuthService {
    let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])
    
    func login(_ id: String, _ password: String) -> Single<NetworkingResult> {
        return provider.rx.request(.login(id: id, password: password))
            .filterSuccessfulStatusCodes()
            .map(AuthModel.self)
            .map { response -> NetworkingResult in
                Token.accessToken = response.accessToken
                Token.refreshToken = response.refreshToken
                UserDefaults.standard.setValue(id, forKey: "userID")
                return .ok
            }
            .catchError { [unowned self] error in
                return Single.just(setNetworkError(error))
            }
    }
    
    func refreshToken() -> Single<NetworkingResult> {
        return provider.rx.request(.refreshToken)
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map { response -> NetworkingResult in
                Token.accessToken = response.accessToken
                return .ok
            }
            .catchError { [unowned self] error in
                return Single.just(setNetworkError(error))
            }
    }
 
    func signup(_ signup: SignupInfo) -> Single<NetworkingResult> {
        return provider.rx.request(.signup(signup))
            .filterSuccessfulStatusCodes()
            .map(AuthModel.self)
            .map { response -> NetworkingResult in
                Token.accessToken = response.accessToken
                Token.refreshToken = response.refreshToken
                UserDefaults.standard.setValue(signup.accountId.value, forKey: "userID")
                return .createOk
            }
            .catchError { [unowned self] error in
                return Single.just(setNetworkError(error))
            }
    }
    
    func setNetworkError(_ error: Error) -> NetworkingResult {
        print(error)
        print(error.localizedDescription)
        guard let status = (error as? MoyaError)?.response?.statusCode else { return .fault }
        return NetworkingResult(rawValue: status) ?? .fault
    }
}
