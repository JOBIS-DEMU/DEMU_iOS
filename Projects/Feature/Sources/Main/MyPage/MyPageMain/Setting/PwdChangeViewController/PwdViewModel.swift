import UIKit
import RxSwift
import RxCocoa
import Moya

class PwdViewModel: ViewModelType {

    private let disposeBag = DisposeBag()

    struct Input {
        let password: Driver<String>
        let doneTap: Signal<Void>
    }

    struct Output {
        let result: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
        let api = AuthService()
        let result = PublishRelay<Bool>()

        input.doneTap.asObservable()
            .withLatestFrom(input.password)
            .flatMap{ password in
                api.checkPwd(password).asObservable()
            }.subscribe(onNext: { res in
                switch res {
                    case .ok:
                        result.accept(true)
                    default:
                        result.accept(false)
                }
            })
            .disposed(by: disposeBag)
        return Output(result: result)
    }
}
