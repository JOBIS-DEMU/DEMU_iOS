//import Foundation
//import RxSwift
//import RxCocoa
//
//class HomeViewModel: ViewModelType {
//    func transform(_ input: Input) -> Output {
//        <#code#>
//    }
//    
//    private let disposeBag = DisposeBag()
//    
//    
//    struct Input {
//        let viewAppear: Signal<Void>
//        let refreshToken: Signal<Void>
//    }
//    
//    
//    struct Output {
//        let post: PublishRelay<PostModel>
//        let result: PublishRelay<Bool>
//        
//    }
//    
//        func transform(_ input: Input) -> Output {
//            let postAPI = PostService()
//            let authAPI = AuthService()
//            let popularPetition = PublishRelay<PostModel>()
//            let result = PublishRelay<Bool>()
//    
//    
//                    input.viewAppear.asObservable()
//                        .flatMap{ postAPI.loadPopularPetition() }
//                        .subscribe(onNext: { data, res in
//                            switch res {
//                                case .ok:
//                                    popularPetition.accept(data!)
//                                default:
//                                    return
//                            }
//                        }).disposed(by: disposeBag)
//            
//                }
//    
//}
