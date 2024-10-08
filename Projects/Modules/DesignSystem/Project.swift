import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "DesignSystem",
    resources: ["Resources/**"],
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Projects.core
    ]
)
