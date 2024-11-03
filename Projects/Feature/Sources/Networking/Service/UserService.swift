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
            .map{ _ -> NetworkingResult in
                print("Success")
                return .ok
            }
            .catch{[unowned self] in return .just(setNetworkError($0))}
    }

    func setNetworkError(_ error: Error) -> NetworkingResult {
           print(error)
           print(error.localizedDescription)
           guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
           return (NetworkingResult(rawValue: status) ?? .fault)
   }
}
