import Foundation
import CryptoKit

enum SHAAlgorithm: String, CaseIterable {
    case sha256
    case sha512
}

typealias SHAHashFunction       = (Data) -> Data
typealias SHAURLHashFunction    = (URL) -> Data?

extension SHAAlgorithm {
    
    func hash(data: Data) -> Data {
        
        switch self {
            
        case .sha256:
            return Data(SHA256.hash(data: data))
            
        case.sha512:
            return Data(SHA512.hash(data: data))
            
        }
        
    }
        
    func hash(url: URL) -> Data? {
        
        var data: Data? = nil
        
        switch self {
            
        case .sha256:
            var hasher = SHA256()
            url.process { hasher.update(bufferPointer: $0) }
            data = Data(hasher.finalize())
            
        case .sha512:
            var hasher = SHA512()
            url.process { hasher.update(bufferPointer: $0) }
            data = Data(hasher.finalize())
            
        }
        
        return data
    
    }
        
}

