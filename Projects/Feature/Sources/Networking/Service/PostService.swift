import Foundation
import UIKit
import RxSwift
import Moya
import RxMoya

final class PostService {
    let provider = MoyaProvider<PostAPI>(plugins: [MoyaLoggerPlugin()])
}
