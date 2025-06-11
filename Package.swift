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
            dependencies: ["ZkNeuralRustCoreFramework", "TensorFlowLiteC"],
            linkerSettings: [.linkedFramework("SystemConfiguration")]
        ),
        .binaryTarget(
            name: "ZkNeuralRustCoreFramework",
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.9/ZkNeuralRustCore.xcframework.zip",
            checksum: "90d4eb7e281fd763f73a1d210bcfe4dbe84364415c8e7a7f5b79f529fcc7891d"
        ),
        .binaryTarget(
            name: "TensorFlowLiteC",
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.9/TensorFlowLiteC.xcframework.zip",
            checksum: "d39d7c8b4f0869b0df8078fb6bafa986dbdc8ace85267d367343875297c518f9"
        ),
        .testTarget(
            name: "ZKNeuralSwiftCoreTests",
            dependencies: ["ZKNeuralSwiftCore"]
        ),
    ]
)
