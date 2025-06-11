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
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.6/ZkNeuralRustCore.xcframework.zip",
            checksum: "01bbf04a9787a1023668fa43cdfc57d048394e9e14be37a0182e0b570cac0b42"
        ),
        .binaryTarget(
            name: "TensorFlowLiteC",
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.6/TensorFlowLiteC.xcframework.zip",
            checksum: "18a039945175352e168da9c3ff2ab202b9b56484460b5526925f7a72f8a76e8a"
        ),
        .testTarget(
            name: "ZKNeuralSwiftCoreTests",
            dependencies: ["ZKNeuralSwiftCore"]
        ),
    ]
)
