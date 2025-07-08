# ZKNeuralSwiftCore

ZKNeuralSwiftCore is a Swift package that provides a high-level interface for generating zero-knowledge proofs (ZKPs) for neural network computations. It leverages a Rust core via FFI and supports invoking TensorFlow Lite models and generating ZKPs for their outputs.

## Features

- **Zero-Knowledge Proof Generation:** Easily generate ZKPs for neural network inference results.
- **Tensor Invoker:** Run TFLite models and obtain outputs in a format suitable for proof generation.
- **Rust Core Integration:** Swift bindings to a performant Rust backend.
- **Callbacks:** Customizable witness and proof generation via Swift closures.

## Usage

Add ZKNeuralSwiftCore as a dependency in your `Package.swift` using Swift Package Manager:

```swift
.package(url: "https://github.com/rarimo/ZKNeuralSwiftCore.git", from: "0.1.0")
```

### Example: Generating a ZK Proof

```swift
import ZKNeuralSwiftCore

let config = ZKNeuralCoreConfiguration(
    generateWitnessCallback: { /* your witness callback */ },
    generateProofCallback: { /* your proof callback */ },
    provingType: ZKNeuralProvingTypeOptions.UltraGroth
)
let core = ZKNeuralCore(configuration: config)
let proof = try core.generateZkProof(inputJson, circuit, zkey)
```

### Example: Invoking a Tensor Model

```swift
let invoker = TensorInvoker(modelData)
let output = try invoker.fireImage(imageData)
```

### Example: Generating Generic Inputs for Circuits

```swift
import ZKNeuralSwiftCore

let invoker = TensorInvoker(modelData)

let inputs = try invoker.drainGenericInputs("3123", "3123", "312", false, imageData, options: ImagePreprocessing::FaceRecognition) 
```

## License

MIT License. See [LICENCE](LICENCE) for details.
