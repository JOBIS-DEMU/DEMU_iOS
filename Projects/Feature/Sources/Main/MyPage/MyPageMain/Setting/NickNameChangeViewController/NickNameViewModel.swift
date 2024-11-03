import Foundation
import RxSwift
import RxCocoa

class NickNameViewModel: ViewModelType {

    private let disposeBag = DisposeBag()

    struct Input {
        let nickname: Driver<String>
        let doneTap: Signal<Void>
    }

    struct Output {
        let result: PublishRelay<NetworkingResult>
    }

    func transform(_ input: Input) -> Output {
        let api = UserService()
        let result = PublishRelay<NetworkingResult>()

        input.doneTap.withLatestFrom(input.nickname).asObservable()
            .flatMap { nickname in
                api.nickname(nickname)
            }
            .bind(to: result)
            .disposed(by: disposeBag)
        return Output(result: result)
    }
}
