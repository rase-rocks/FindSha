//
//  fns.swift
//  FindSha
//
//  Created by Robert Atherton on 22/03/2019.
//  Copyright © 2019 Robert Atherton. All rights reserved.
//

import Foundation

func shell(launchPath: String, arguments: [String] = []) -> (String? , Int32) {
    
    let task            = Process()
    task.launchPath     = launchPath
    task.arguments      = arguments
    
    let pipe            = Pipe()
    task.standardOutput = pipe
    task.standardError  = pipe
    
    task.launch()
    
    let data            = pipe.fileHandleForReading.readDataToEndOfFile()
    let output          = String(data: data, encoding: .utf8)
    
    task.waitUntilExit()
    
    return (output, task.terminationStatus)
    
}

func absURL ( _ path: String ) -> URL {
    
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

func absPath ( _ path: String ) -> String {
    return absURL(path).path
}
