//
//  CLI.swift
//  FindSha
//
//  Created by Robert Atherton on 22/03/2019.
//  Copyright © 2019 Robert Atherton. All rights reserved.
//

import Foundation

public final class CLI {
    
    private let searchPath  : String
    private let searchSha   : String
    private let algorithm   : HashAlgorithm
    
    public init?(arguments: [String] = CommandLine.arguments) {
        
        let args            = Arguments(commandLineArguments: arguments)
        
        guard let searchSha = args.searchSha,
            let searchPath  = args.searchPath,
            let algorithm   = args.algorithm else {
                return nil
        }
        
        self.searchPath     = searchPath
        self.searchSha      = searchSha
        self.algorithm      = algorithm
        
    }
    
    func startMessage(hash: String, algorithm: String, path: String) -> String {
        return """
        
    Starting Search - \(algorithm)
    ========================

    Searching in \(path)

    Searching for \(hash)
"""
    }
    
    func foundMessage(hash: String, url: URL) -> String {
        return """
        
    Matching file found
    ===================

    \(url)
        
"""
    }
    
    func endMessage(count: Int, path: String) -> String {
    
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
    
    public func run() throws {
        
        let result          = shell(launchPath  : "/bin/ls",
                                    arguments   : [searchPath])
        
        guard let listing   = result.0 else { return }
        
        print(startMessage(hash: searchSha, algorithm: algorithm.rawValue, path: searchPath))
        
        var count           = 0
        
        let urls            = listing
            .split(separator: "\n")
            .map { URL(fileURLWithPath: "\(searchPath)/\($0)") }
        
        
        for url in urls {
            
            guard let data  = NSData(contentsOf: url) else { continue }
            
            let hash        = Hash.process(data: data, using: algorithm)
            
            if hash == searchSha {
                count += 1
                print(foundMessage(hash: searchSha, url: url))
            }
            
        }
        
        print(endMessage(count: count, path: searchPath))

    }
}
