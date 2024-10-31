import Foundation
import RxSwift
import RxCocoa

class SignupInfo {
    static let shared = SignupInfo()
    var userName = BehaviorRelay<String?>(value: nil)
    var accountId = BehaviorRelay<String?>(value: nil)
    var password = BehaviorRelay<String?>(value: nil)
    private init() { }
}
