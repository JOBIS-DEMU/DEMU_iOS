import Foundation
import RxSwift
import RxCocoa
import Core

class LoginViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let id: Driver<String>
        let password: Driver<String>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        
    }
}
