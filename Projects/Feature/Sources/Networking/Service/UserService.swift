import Foundation
import UIKit
import RxSwift
import Moya
import RxMoya

final class UserService {
    let provider = MoyaProvider<UserAPI>(plugins: [MoyaLoggerPlugin()])

    func nickname(_ nickname: String) -> Single<NetworkingResult> {
        return provider.rx.request(.nickname(nickname: nickname))
            .filterSuccessfulStatusCodes()
            .map { _ in
                print("Success")
                return .ok
            }
            .catch { [weak self] error in
                guard let self = self else { return .just(.fault) }
                return .just(self.setNetworkError(error))
            }
    }

    func setNetworkError(_ error: Error) -> NetworkingResult {
           print(error)
           print(error.localizedDescription)
           guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
           return (NetworkingResult(rawValue: status) ?? .fault)
   }
}
