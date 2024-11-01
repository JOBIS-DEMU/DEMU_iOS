import Foundation
import UIKit
import RxSwift
import Moya
import RxMoya

final class AuthService {
    let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])

    func login(_ id: String, _ password: String) -> Single<NetworkingResult> {
        return provider.rx.request(.login(email: id, password: password))
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

    func signup(_ id: String, _ username: String, _ password: String) -> Single<NetworkingResult> {
        return provider.rx.request(.signup(email: id, nickname: username, password: password))
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

    func emailsend(_ email: String) -> Single<NetworkingResult> {
        return provider.rx.request(.emailsend(email: email))
            .filterSuccessfulStatusCodes()
            .map{ _ -> NetworkingResult in
                print("Success")
                return .ok
            }
            .catch{[unowned self] in return .just(setNetworkError($0))}
    }

    func checkPwd(_ password: String) -> Single<NetworkingResult> {
        return provider.rx.request(.checkPwd(password: password))
            .filterSuccessfulStatusCodes()
            .map(AuthModel.self)
            .map { response -> NetworkingResult in
                Token.accessToken = response.accessToken
                Token.refreshToken = response.refreshToken
                UserDefaults.standard.setValue(password, forKey: "userID")
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

    func setNetworkError(_ error: Error) -> NetworkingResult {
        print(error)
        print(error.localizedDescription)
        guard let status = (error as? MoyaError)?.response?.statusCode else { return .fault }
        return NetworkingResult(rawValue: status) ?? .fault
    }
}
