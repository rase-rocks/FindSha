//
//  ArrayElementAfterTests.swift
//  FindShaTests
//
//  Created by Robert Atherton on 15/03/2020.
//  Copyright © 2020 Robert Atherton. All rights reserved.
//

import XCTest

class ArrayElementAfterTests: XCTestCase {

    func testInBounds() {
        
        let arr = [
            0,
            1,
            2
        ]
        
        let elAfter = arr.element(after: 0)
        
        XCTAssertEqual(elAfter, 1)
        
    }
    
    func testNegative() {
        
        XCTAssertNil([].element(after: -1))
        
    }

}
