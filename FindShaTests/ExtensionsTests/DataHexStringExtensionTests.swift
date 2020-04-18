import XCTest

class DataHexStringTests: XCTestCase {

    func testHex() {
        
        let data = Data(repeating: 255, count: 4)
        let expectedHexString = "FFFFFFFF".lowercased()
        
        XCTAssertEqual(data.hex, expectedHexString)
        
    }
    
    func testKnownGoodValue() {
        
        let testString = "This is the string"
        let hex = testString.data(using: .utf8)!.hex
        let expected = "546869732069732074686520737472696e67"
        
        XCTAssertEqual(hex, expected)
        
        let data = Data(hexString: hex)!
        let returnedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(returnedString, testString)
        
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
