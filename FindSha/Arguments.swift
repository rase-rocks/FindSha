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
    
    init(commandLineArguments arguments: [String]) {
        
        for (index, argument) in arguments.enumerated() {

            switch argument.lowercased() {

            case "--in", "-i":
                if let path = arguments.element(after: index) {
                    searchPath = path
                }
                
            case "--sha", "-s":
                if let sha = arguments.element(after: index) {
                    searchSha = sha
                }

            default:
                break
            }

        }
        
    }
    
    static func getPath(fullPath: String?) -> String {
        
        guard let fullPath = fullPath else { return "" }
        
        return absPath(fullPath.split(separator: "/")
            .dropLast()
            .joined(separator: "/"))
        
    }
    
}
