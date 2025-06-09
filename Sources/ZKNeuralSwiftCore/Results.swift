import Foundation
import ZkNeuralRustCoreLib

public enum ZkNeuralCoreError: Error {
    case RustCoreError(String)
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

func withRustResult(
    _ body: () -> UnsafeMutablePointer<ZkNeuralCoreResult>?
) throws -> Data {
    guard let resultPtr = body() else {
        throw ZkNeuralCoreError.RustCoreError("Failed to get result")
    }
    defer { rs_zkneural_dealloc_result(resultPtr) }
    return try resultPtr.pointee.asSwiftResult().getData()
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
