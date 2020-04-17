import Foundation

struct SHADigestImporter {
    
    static func shas(from data: Data) -> [SHADigest] {
        
        guard let string = String(data: data, encoding: .utf8) else { return [] }
        
        return shas(from: string)
            
    }
    
    static func shas(from string: String) -> [SHADigest] {
        return string
            .split(separator: "\n")
            .map { $0.split(separator: ",").map { String($0) } }
            .flatMap { $0 }
            .compactMap { SHADigest(hexString: $0) }
            .reduce(into: [SHADigest]()) { if !$0.contains($1) { $0.append($1) } } // Preserve original order over more efficient Set implementation
    }
    
}
