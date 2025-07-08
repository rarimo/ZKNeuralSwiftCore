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
            dependencies: ["ZkNeuralRustCoreFramework", "TensorFlowLiteCLib"],
            linkerSettings: [.linkedFramework("SystemConfiguration")]
        ),
        .binaryTarget(
            name: "ZkNeuralRustCoreFramework",
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.15/ZkNeuralRustCore.xcframework.zip",
            checksum: "06809815d1d963be44c0978a665ceb5203dbffc045f8dbdd09f5d039452a6970"
        ),
        .binaryTarget(
            name: "TensorFlowLiteCLib",
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.15/TensorFlowLiteC.xcframework.zip",
            checksum: "bc70dfeb27a9e61f9788cdf8dd65e4b804c1bc207129c8131ad8a80c342f67db"
        ),
        .testTarget(
            name: "ZKNeuralSwiftCoreTests",
            dependencies: ["ZKNeuralSwiftCore"]
        ),
    ]
)
