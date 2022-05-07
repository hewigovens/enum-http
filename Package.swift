// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "EnumHttp",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "EnumHttp",
            targets: ["EnumHttp"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "EnumHttp",
            dependencies: []),
        .testTarget(
            name: "EnumHttpTests",
            dependencies: ["EnumHttp"]),
    ]
)
