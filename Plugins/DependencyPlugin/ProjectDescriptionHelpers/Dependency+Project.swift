import ProjectDescription

public extension TargetDependency {
    struct Projects {}
    struct Module {}
}

public extension TargetDependency.Projects {
    static let core = project(name: "Core")
    static let service = project(name: "Service")
    static let feature = project(name: "Feature")
    
    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/\(name)")
        )
    }
}

public extension TargetDependency.Module {
    static let designSystem = module(name: "DesignSystem")
    static let thirdPartyLib = module(name: "ThirdPartyLib")

    static func module(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/Modules/\(name)")
        )
    }
}
