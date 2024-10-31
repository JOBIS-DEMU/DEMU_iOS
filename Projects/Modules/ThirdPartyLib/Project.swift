import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLib",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .SPM.Moya,
        .SPM.RxMoya,
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.KeychainSwift,
        .SPM.SwiftKeychainWrapper,
        .SPM.Kingfisher
    ]
)
