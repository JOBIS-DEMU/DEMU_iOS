import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel: ViewModelType {

    private let disposeBag = DisposeBag()

    struct Input {
        let email: Driver<String>
        let nickname: Driver<String>
        let password: Driver<String>
        let doneTap: Signal<Void>
    }

    struct Output {
        let result: PublishRelay<NetworkingResult>
    }

    func transform(_ input: Input) -> Output {
        let api = AuthService()
        let info = Driver.combineLatest(input.email, input.nickname, input.password)
        let result = PublishRelay<NetworkingResult>()

        input.doneTap.withLatestFrom(info).asObservable()
            .flatMapLatest {
                email, nickname, password in
                api.signup(email+"@dsm.hs.kr", nickname, password)
            }
            .bind(to: result)
            .disposed(by: disposeBag)
        return Output(result: result)
    }

}
