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
