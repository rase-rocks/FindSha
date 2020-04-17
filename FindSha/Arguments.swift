import Foundation

struct Arguments {
    
    var searchPath      : String?
    var searchDigest    : SHADigest?
    
    init(commandLineArguments arguments: [String]) {
        
        for (index, argument) in arguments.enumerated() {

            switch argument.lowercased() {

            case "--in", "-i":
                
                if let path = arguments.element(after: index) {
                    searchPath = path
                }
                                
            case "--sha", "-s":
                
                guard let shaHexString = arguments.element(after: index),
                    let sha = SHADigestImporter.shas(from: shaHexString).first else { break }
                
                searchDigest = sha

            default:
                break
            }

        }
        
    }
    
}
