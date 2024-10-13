import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLib",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .SPM.Moya,
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.RxSwift
    ]
)
