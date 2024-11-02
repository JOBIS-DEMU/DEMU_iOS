import Foundation
import RxSwift
import RxCocoa

class BlogViewModel: ViewModelType {

    private let disposeBag = DisposeBag()

    struct Input {
        let title: Driver<String>
        let content: Driver<String>
        let major: Driver<String>
        let doneTap: Signal<Void>
    }

    struct Output {
        let result: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
        let api = PostService()
        let info = Driver.combineLatest(input.title, input.content, input.major)
        let result = PublishRelay<Bool>()

        input.doneTap.withLatestFrom(info).asObservable()
            .flatMapLatest { title, content, major in
                api.postCreate(title, content: content, major: major)
            }
            .subscribe(onNext: { res in
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
