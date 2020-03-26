//
//  Arguments.swift
//  FindSha
//
//  Created by Robert Atherton on 22/03/2019.
//  Copyright © 2019 Robert Atherton. All rights reserved.
//

import Foundation

struct Arguments {
    
    var searchPath      : String?
    var searchSha       : String?
    var algorithm       : HashAlgorithm?
    
    init(commandLineArguments arguments: [String]) {
        
        for (index, argument) in arguments.enumerated() {

            switch argument.lowercased() {

            case "--in", "-i":
                if let path = arguments.element(after: index) {
                    searchPath  = path
                }
                
            case "--sha", "-s", "--sha256", "-s256":
                if let sha = arguments.element(after: index) {
                    searchSha   = sha
                    algorithm   = .sha256
                }
                
            case "--sha512", "-s512":
                if let sha = arguments.element(after: index) {
                    searchSha   = sha
                    algorithm   = .sha512
                }

            default:
                break
            }

        }
        
    }
    
}
