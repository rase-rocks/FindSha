import Foundation

struct SHADigest {
    
    let data        : Data
    let hex         : String
    let algorithm   : SHAAlgorithm

    init?(hexString: String) {
        
        let trimmed     = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let alg   = SHADigest.algorithmFor(for: trimmed) else { return nil }
        let lowerCase   = trimmed.lowercased()
        guard let data  = Data(hexString: lowerCase) else { return nil }
             
        self.data       = data
        self.hex        = lowerCase
        self.algorithm  = alg
        
    }
    
    func isEqual(toDigest data: Data) -> Bool {
        return self.data == data
    }
    
}

extension SHADigest: Hashable {}

extension SHADigest: Equatable {}

func ==(lhs: SHADigest, rhs: SHADigest) -> Bool {
    return lhs.hex == rhs.hex
}

extension SHADigest {
    
    static let sha256Re = #"^[A-Fa-f0-9]{64}$"#
    static let sha512Re = #"^[A-Fa-f0-9]{128}$"#
    
    static func isPattern(string    : String,
                          pattern   : String) -> Bool {
        
        return string.range(of      : pattern,
                            options : .regularExpression) != nil
        
    }
    
    static func algorithmFor(for string: String) -> SHAAlgorithm? {
        
        if string.isEmpty || string.count > 128 { return nil }
        
        if isPattern(string: string, pattern: sha256Re) {
            return .sha256
        } else if isPattern(string: string, pattern: sha512Re) {
            return .sha512
        } else {
            return nil
        }
        
    }
    
}
