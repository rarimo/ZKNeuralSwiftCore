import Foundation

import Testing
@testable import ZKNeuralSwiftCore

@Test func testTensorInvoker() async throws {
    let model_path = Bundle.main.path(forResource: "BioNetV3", ofType: "tflite")

    print("Model path: \(model_path ?? "Not found")")

//    let invoker = TensorInvoker()
}
