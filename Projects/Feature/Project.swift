import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Feature",
    resources: ["Resources/**"],
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Projects.service,
        .Module.designSystem
    ]
)
