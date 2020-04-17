import XCTest
import CryptoKit

class SHADigestTests: XCTestCase {
    
    func testKnownGoodValues256() {
        
        let sha256 = [
            "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782",
            "6579ea6175313eec2ce0f343c5db52d969d42b88d43adcb2c75f90a0ecc3b90c",
            " 5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782",
            "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782 ",
            " 5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782 "
        ]
        
        sha256.forEach { str in
            let sha = SHADigest(hexString: str)
            XCTAssertNotNil(sha)
            XCTAssertEqual(sha?.algorithm, .sha256)
        }
        
    }
    
    func testKnownGoodValues512() {
        
        let sha512 = [
            "124cfa43ecacbd72401439dd1a30bbd53b2da278adc64bdfee0b9b678e3aed58f885bf94ef7d43fd1a968063014339df1e2e7cbe83826cd219cfd8a683b1f8aa",
            "f6abe2df2165d12d45c0d2ed2f25526f88e6c2001ef5d336b9a3b0ed561d27baa043b8ebf859c31bd0f94b169d2ce93013027282add676d8ce5ecc8d6302c67e",
            " 124cfa43ecacbd72401439dd1a30bbd53b2da278adc64bdfee0b9b678e3aed58f885bf94ef7d43fd1a968063014339df1e2e7cbe83826cd219cfd8a683b1f8aa",
            "124cfa43ecacbd72401439dd1a30bbd53b2da278adc64bdfee0b9b678e3aed58f885bf94ef7d43fd1a968063014339df1e2e7cbe83826cd219cfd8a683b1f8aa ",
            " 124cfa43ecacbd72401439dd1a30bbd53b2da278adc64bdfee0b9b678e3aed58f885bf94ef7d43fd1a968063014339df1e2e7cbe83826cd219cfd8a683b1f8aa "
        ]
        
        sha512.forEach { str in
            let sha = SHADigest(hexString: str)
            XCTAssertNotNil(sha)
            XCTAssertEqual(sha?.algorithm, .sha512)
        }
        
    }
    
    func testMultipleValues() {
        
        let tests: [(string: String, algorithm: SHAAlgorithm?)] = [
            (string: "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782", algorithm: .sha256),
            (string: "124cfa43ecacbd72401439dd1a30bbd53b2da278adc64bdfee0b9b678e3aed58f885bf94ef7d43fd1a968063014339df1e2e7cbe83826cd219cfd8a683b1f8aa", algorithm: .sha512),
            (string: "", algorithm: nil),
            (string: "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6-f782", algorithm: nil),
            (string: "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef78", algorithm: nil),
            (string: "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef7-", algorithm: nil)
        ]
        
        tests.forEach { test in
            
            let sha = SHADigest(hexString: test.string)
            XCTAssertEqual(sha?.algorithm, test.algorithm)
            
        }
        
    }
    
    func testEquality() {
        let sha1 = SHADigest(hexString: "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782")!
        let sha2 = SHADigest(hexString: "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782")!
        
        XCTAssertEqual(sha1, sha2)
    }
    
    func testInEquality() {
        let sha1 = SHADigest(hexString: "6e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782")!
        let sha2 = SHADigest(hexString: "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782")!
        
        XCTAssertNotEqual(sha1, sha2)
    }
    
    func testIsEqualToDigest() {
        
        let data = "This is the string to digest".data(using: .utf8)!
        
        let digest256 = Data(SHA256.hash(data: data))
        let hex256 = digest256.hex
        let sha256 = SHADigest(hexString: hex256)!
        
        XCTAssertEqual(sha256.algorithm, .sha256)
        XCTAssertTrue(sha256.isEqual(toDigest: digest256))
        
        let digest512 = Data(SHA512.hash(data: data))
        let hex512 = digest512.hex
        let sha512 = SHADigest(hexString: hex512)!
        
        XCTAssertEqual(sha512.algorithm, .sha512)
        XCTAssertTrue(sha512.isEqual(toDigest: digest512))
        XCTAssertFalse(sha512.isEqual(toDigest: digest256))
        
    }
    
    func testAlgorithmFor() {
        
        let notShaDigest = "This is not a digest"
        let alg = SHADigest.algorithmFor(for: notShaDigest)
        
        XCTAssertNil(alg)
        
    }

}

