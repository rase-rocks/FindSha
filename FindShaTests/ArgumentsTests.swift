import XCTest

class ArgumentsTests: XCTestCase {

    let sha = SHADigest(hexString: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")!
    
    func testShortArguments() {
        
        let args = ["-i", "./", "-s", sha.hex]
        
        let arguments = Arguments(commandLineArguments: args)
        
        XCTAssertEqual(arguments.searchPath, "./")
        XCTAssertEqual(arguments.searchDigest, sha)
        
    }

}
