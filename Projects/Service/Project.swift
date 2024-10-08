import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Service",
    platform: .iOS,
    product: .framework,
    dependencies: [
        .Projects.core
    ]
)
