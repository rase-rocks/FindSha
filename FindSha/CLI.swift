import Foundation

public final class CLI {
    
    private let searchPath  : String
    private let searchDigest: SHADigest
    
    public init?(arguments: [String] = CommandLine.arguments) {
        
        let args            = Arguments(commandLineArguments: arguments)
        
        guard let searchPath  = args.searchPath,
            let searchDigest  = args.searchDigest else {
                return nil
        }
        
        self.searchPath     = searchPath
        self.searchDigest   = searchDigest
        
    }
    
    public func runRecursive() {
        
        let url                 = absURL(searchPath)
        guard let enumerator    = FileManager.default.enumerator(at: url, includingPropertiesForKeys: nil) else {
            print(CLI.endMessage(count: 0, path: searchPath))
            return
        }
        
        print(CLI.startMessage(hash: searchDigest.hex, algorithm: searchDigest.algorithm.rawValue, path: searchPath))
        
        var count               = 0
        
        for case let fileURL as URL in enumerator {
            if !fileURL.hasDirectoryPath {
                                                
                if let hashData = searchDigest.algorithm.hash(url: fileURL) {
                    
                    if searchDigest.isEqual(toDigest: hashData) {
                        
                        count += 1
                        print(CLI.foundMessage(hash: searchDigest.hex, url: fileURL))
                        
                    }
                    
                }
                
            }
        }
        
        print(CLI.endMessage(count: count, path: searchPath))
        
    }
    
}

// MARK: URL handling

extension CLI {
    
    func absURL (_ path: String) -> URL {
        
        guard path != "~" else {
            return FileManager.default.homeDirectoryForCurrentUser
        }
        
        guard path.hasPrefix("~/") else { return URL(fileURLWithPath: path)  }
        
        var relativePath = path
        relativePath.removeFirst(2)
        
        return URL(fileURLWithPath  : relativePath,
                   relativeTo       : FileManager.default.homeDirectoryForCurrentUser
        )
        
    }
    
}

// MARK: Messages

extension CLI {
    
    static func startMessage(hash: String, algorithm: String, path: String) -> String {
        return """
        
        Starting Search - \(algorithm)
        ========================

        Recursively Searching in \(path)

        Searching for \(hash)
        
        """
    }
    
    static func foundMessage(hash: String, url: URL) -> String {
        return """
        
        Matching file found
        ===================
        
        \(url)
        
        """
    }
    
    static func endMessage(count: Int, path: String) -> String {
        
        let found = """
        
        End of search
        =============
        
        Hash found \(count) times
        
        """
        
        let notFound = """
        
        Search completed - Not Found
        ============================
        
        The search has completed and the hash was not found in
        \(path)
        
        """
        
        return count == 0 ? notFound : found
        
    }
    
}
