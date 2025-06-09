// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ZkNeuralRustCoreLib

public struct ZKNeuralCoreConfiguration {
    public let generateWitnessCallback: GenerateWitnessCallback
    public let generateProofCallback: GenerateProofCallback
}

public class ZKNeuralCore {
    let configuration: ZKNeuralCoreConfiguration
    let innerCore: OpaquePointer!

    init(
        configuration: ZKNeuralCoreConfiguration
    ) {
        self.configuration = configuration
        self.innerCore = rs_zkneural_new()

        rs_zkneural_set_generate_witness_callback(innerCore, configuration.generateWitnessCallback)
        rs_zkneural_set_generate_proof_callback(innerCore, configuration.generateProofCallback)
    }

    func generateZkProof(
        _ inputJson: Data,
        _ circuit: Data,
        _ zkey: Data
    ) throws -> Data {
        let witnessGenerationCResult = rs_zkneural_generate_witness(
            innerCore,
            (circuit as NSData).bytes,
            .init(circuit.count),
            (inputJson as NSData).bytes,
            .init(circuit.count)
        )

        guard let witnessGenerationResult = witnessGenerationCResult?.pointee.asSwiftResult() else {
            throw ZkNeuralCoreError.RustCoreError("Failed to generate witness")
        }

        rs_zkneural_dealloc_result(witnessGenerationCResult)

        let witnessData = try witnessGenerationResult.getData()

        return Data()
    }

    deinit {
        rs_zkneural_free(innerCore)
    }
}

extension ZkNeuralCoreResult {
    func asSwiftResult() -> ZkNeuralCoreSwiftResult {
        if error != nil {
            let errorMessage = String(cString: error!)

            return .failure(ZkNeuralCoreError.RustCoreError(errorMessage))
        }

        let resultData = Data(bytes: value, count: .init(value_size))

        return .success(resultData)
    }
}

enum ZkNeuralCoreSwiftResult {
    case success(Data)
    case failure(Error)

    var data: Data? {
        switch self {
        case .success(let data):
            return data
        case .failure:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }

    func getData() throws -> Data {
        switch self {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}

public enum ZkNeuralCoreError: Error {
    case RustCoreError(String)
}
