import Foundation
import UIKit
import RxSwift
import Moya
import RxMoya

final class PostService {
    let provider = MoyaProvider<PostAPI>(plugins: [MoyaLoggerPlugin()])

    func postCreate(_ title: String, content: String, major: String) -> Single<NetworkingResult> {
        return provider.rx.request(.postCreate(title: title, content: content, major: major))
            .filterSuccessfulStatusCodes()
            .map{ _ -> NetworkingResult in
                print("Success")
                return .createOk
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
