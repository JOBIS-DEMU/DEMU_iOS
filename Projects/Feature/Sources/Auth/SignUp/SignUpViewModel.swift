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
        let result: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
        let api = AuthService()
        let info = Driver.combineLatest(input.email, input.nickname, input.password)
        let result = PublishRelay<Bool>()

        input.doneTap.withLatestFrom(info).asObservable()
            .flatMap {
                email, nickname, password -> PrimitiveSequence<SingleTrait, Bool> in
                api.signup(email, nickname, password).map { res in
                    return res == NetworkingResult.ok
                }
            }
            .bind(to: result)
            .disposed(by: disposeBag)
        return Output(result: result)
    }

}
