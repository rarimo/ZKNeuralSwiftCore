// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZKNeuralSwiftCore",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ZKNeuralSwiftCore",
            targets: ["ZKNeuralSwiftCore", "ZkNeuralRustCoreFramework"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ZKNeuralSwiftCore",
            dependencies: ["ZkNeuralRustCoreFramework"],
            linkerSettings: [.linkedFramework("SystemConfiguration")]
        ),
        .binaryTarget(
            name: "ZkNeuralRustCoreFramework",
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.4/ZkNeuralRustCore.xcframework.zip",
            checksum: "2a091b861c2ecfbf2a627d7644ffbb7c00bc4f143d2d6311998a13cff2944716"
        ),
        .testTarget(
            name: "ZKNeuralSwiftCoreTests",
            dependencies: ["ZKNeuralSwiftCore"]
        ),
    ]
)
