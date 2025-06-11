// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ZkNeuralRustCoreLib

public struct ZKNeuralCoreConfiguration {
    public let generateWitnessCallback: GenerateWitnessCallback
    public let generateProofCallback: GenerateProofCallback
}

public class ZKNeuralCore {
    private let configuration: ZKNeuralCoreConfiguration
    private let innerCore: OpaquePointer!

    public init(
        configuration: ZKNeuralCoreConfiguration
    ) {
        self.configuration = configuration
        self.innerCore = rs_zkneural_new()

        rs_zkneural_set_generate_witness_callback(innerCore, configuration.generateWitnessCallback)
        rs_zkneural_set_generate_proof_callback(innerCore, configuration.generateProofCallback)
    }

    public func generateZkProof(
        _ inputJson: Data,
        _ circuit: Data,
        _ zkey: Data
    ) throws -> Data {
        let wtns = try withRustResult {
            rs_zkneural_generate_witness(
                innerCore,
                (circuit as NSData).bytes,
                .init(circuit.count),
                (inputJson as NSData).bytes,
                .init(circuit.count)
            )
        }

        return try withRustResult {
            rs_zkneural_generate_proof(
                innerCore,
                (zkey as NSData).bytes,
                .init(zkey.count),
                (wtns as NSData).bytes,
                .init(wtns.count)
            )
        }
    }

    deinit {
        rs_zkneural_free(innerCore)
    }
}

public class TensorInvoker {
    private let invoker: OpaquePointer!

    public init(_ model_data: Data) {
        self.invoker = rs_zkneural_tensor_invoker_new(
            (model_data as NSData).bytes,
            .init(model_data.count)
        )
    }

    public func fire_image(_ image_data: Data) throws -> Data {
        try withRustResult {
            rs_zkneural_tensor_invoker_image_fire(
                self.invoker,
                (image_data as NSData).bytes,
                .init(image_data.count)
            )
        }
    }

    deinit {
        rs_zkneural_tensor_invoker_free(invoker)
    }
}
