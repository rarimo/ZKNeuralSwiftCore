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
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.5/ZkNeuralRustCore.xcframework.zip",
            checksum: "01bbf04a9787a1023668fa43cdfc57d048394e9e14be37a0182e0b570cac0b42"
        ),
        .binaryTarget(
            name: "TensorFlowLiteC",
            url: "https://github.com/rarimo/zk-neural-rust-core/releases/download/v0.1.5/TensorFlowLiteC.xcframework.zip",
            checksum: "e77c317adc7c3a65179c14abcc93322150f9ccb972a3b0a1b52b5ff91ab99815"
        ),
        .testTarget(
            name: "ZKNeuralSwiftCoreTests",
            dependencies: ["ZKNeuralSwiftCore"]
        ),
    ]
)
