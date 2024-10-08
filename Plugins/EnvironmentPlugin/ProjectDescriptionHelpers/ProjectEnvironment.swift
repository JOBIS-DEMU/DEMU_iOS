import ProjectDescription

public struct ProjectEnvironment {
    public let appName: String
    public let targetName: String
    public let organizationName: String
    public let deploymentTarget: DeploymentTarget
    public let platform: Platform
    public let baseSetting: SettingsDictionary
}

public let env = ProjectEnvironment(
    appName: "ProjectName",
    targetName: "ProjectName",
    organizationName: "com.bundle.id",
    deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
    platform: .iOS,
    baseSetting: ["OTHER_LDFLAGS": ["$(inherited) -Objc"]]
)
