// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "alter-sdk",
    defaultLocalization: "en",
    platforms: [
            .iOS(.v13)
    ],
    products: [
        .library(
            name: "alter-sdk",
            targets: ["AlterSDK", "AlterSDKDependencies"]),
    ],
    dependencies: [
        .package(name: "AlterCore", url: "https://github.com/facemoji/alter-core/", from: "0.14.3")
    ],
    targets: [
        .binaryTarget(
                    name: "AlterSDK",
                    path: "frameworks/AlterSDK.xcframework"
                ),
        
        // see https://stackoverflow.com/questions/65220359/add-package-dependency-for-a-binary-target-with-swift-package-manager
        .target(name: "AlterSDKDependencies", dependencies: [
            .product(name: "alter-core", package: "AlterCore"),
            "AlterSDK"
        ], path: "./ios-example/libs", linkerSettings: [
            .linkedFramework("AlterCore")
        ])
    ]
)
