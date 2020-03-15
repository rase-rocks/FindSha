//
//  ArgumentsTests.swift
//  FindShaTests
//
//  Created by Robert Atherton on 15/03/2020.
//  Copyright © 2020 Robert Atherton. All rights reserved.
//

import XCTest

class ArgumentsTests: XCTestCase {

    let sha = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    
    func testShortArguments() {
        
        let args = ["-i", "./", "-s", sha]
        
        let arguments = Arguments(commandLineArguments: args)
        
        XCTAssertEqual(arguments.searchPath, "./")
        XCTAssertEqual(arguments.searchSha, sha)
        
    }

}
