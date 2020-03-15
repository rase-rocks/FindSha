//
//  Hash.swift
//  FindSha
//
//  Created by Robert Atherton on 22/03/2019.
//  Copyright © 2019 Robert Atherton. All rights reserved.
//

import Foundation

enum HashAlgorithm: String, Codable {
    case sha256             = "sha256"
    case sha512             = "sha512"
}

typealias DigestFunction    = (NSData) -> NSData
typealias HashFunction      = (UnsafeRawPointer?, UInt32, UnsafeMutablePointer<UInt8>?) -> UnsafeMutablePointer<UInt8>?

struct Hash {
    
    private static func digest(algorithm: HashAlgorithm) -> DigestFunction {
        
        switch algorithm {
            
        case .sha256:
            return Hash.makeDigest(digestLength: CC_SHA256_DIGEST_LENGTH, hashFunction: CC_SHA256)
            
        case .sha512:
            return Hash.makeDigest(digestLength: CC_SHA512_DIGEST_LENGTH, hashFunction: CC_SHA512)
            
        }
        
    }
    
    private static func makeDigest(digestLength: Int32, hashFunction: @escaping HashFunction) -> DigestFunction {
        
        return { input in
            
            let digestLength    = Int(digestLength)
            var hash            = [UInt8](repeating: 0, count: digestLength)
            
            return NSData(bytes: hashFunction(input.bytes, UInt32(input.length), &hash), length: digestLength)
        }
    }
    
}

extension Hash {
    
    static func process(string: String, using algorithm: HashAlgorithm) -> String {
        
        guard let stringData    = string.data(using: String.Encoding.utf8) else  { return "" }
        let nsData              = stringData as NSData
        
        return Hash.digest(algorithm: algorithm)(nsData).hexString
        
    }
    
    static func process(data: NSData, using algorithm: HashAlgorithm) -> String {
        return Hash.digest(algorithm: algorithm)(data).hexString
    }
    
}
