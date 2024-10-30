import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {

    private let disposeBag = DisposeBag()
    
    struct Input {
        let id: Driver<String>
        let password: Driver<String>
        let doneTap: Signal<Void>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let api = AuthService()
        let info = Driver.combineLatest(input.id, input.password)
        let result = PublishRelay<Bool>()
        
        input.doneTap.withLatestFrom(info).asObservable().flatMap {
            id, password in
            api.login(id, password)
        }.subscribe(onNext: { res in
            switch res {
                case .ok:
                    result.accept(true)
                default:
                    result.accept(false)
            }
        }).disposed(by: disposeBag)
        return Output(result: result)
    }
    
}
