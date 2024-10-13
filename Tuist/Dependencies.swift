import ProjectDescription
import ConfigurationPlugin

let dependencies = Dependencies.init(
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            //moya
            .remote(
                url: "https://github.com/Moya/Moya.git",
                requirement: .upToNextMajor(from: "15.0.3")
            ),
            // RxSwift
            .remote(url: "https://github.com/ReactiveX/RxSwift",
                    requirement: .upToNextMajor(from: "6.7.1")
                   ),
            
            // SnapKit
            .remote(
                url: "https://github.com/SnapKit/SnapKit.git",
                requirement: .upToNextMajor(from: "5.0.1")
            ),
            
            // Then
            .remote(
                url: "https://github.com/devxoul/Then.git",
                requirement: .upToNextMajor(from: "3.0.0")
            )
        ]
        
//        
//        baseSettings: .settings(
//            configurations: [
//                .debug(name: .stage),
//                .release(name: .prod)
//            ]
//        )
    ),
    platforms: [.iOS]
)
