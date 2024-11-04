import Foundation
import RxSwift
import RxCocoa

class BlogViewModel: ViewModelType {

    private let disposeBag = DisposeBag()

    struct Input {
        let title: Driver<String>
        let content: Driver<String>
        let major: Driver<String>
        let images: Driver<[Data]>
        let doneTap: Signal<Void>
    }

    struct Output {
           let result: Observable<Bool>
       }

    func transform(_ input: Input) -> Output {
        let api = PostService()
        let info = Driver.combineLatest(input.title, input.content, input.major, input.images)
        let result = PublishRelay<Bool>()

        input.doneTap.withLatestFrom(info).asObservable()
            .flatMapLatest { title, content, major, images in
                api.postCreate(title, content: content, major: major.uppercased(), images: images)
            }
            .subscribe(onNext: { res in
                switch res {
                case .createOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            })
            .disposed(by: disposeBag)
        return Output(result: result.asObservable())
    }

}
