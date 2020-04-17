import XCTest

class DataHexStringTests: XCTestCase {

    func testHex() {
        
        let data = Data(repeating: 255, count: 4)
        let expectedHexString = "FFFFFFFF".lowercased()
        
        XCTAssertEqual(data.hex, expectedHexString)
        
    }
    
    func testInitFromHexString() {
        
        let hexString = "FFFFFFFF".lowercased()
        let expectedData = Data(repeating: 255, count: 4)
        
        XCTAssertEqual(Data(hexString: hexString), expectedData)
        
    }
    
    func testInvalidHex() {
        
        let invalid = "GGFFFFFF".lowercased()
        
        XCTAssertNil(Data(hexString: invalid))
        
    }

}
