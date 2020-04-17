import XCTest
import CryptoKit

// Reference values from macOS openssl sha256 / sha512 implementation

class SHAAlgorithmTests: XCTestCase {

    let tests: [(name: String, ext: String, sha256: SHADigest, sha512: SHADigest)] = [
            (name: "258",
             ext: "pdf",
             sha256: SHADigest(hexString: "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782")!,
             sha512: SHADigest(hexString: "124cfa43ecacbd72401439dd1a30bbd53b2da278adc64bdfee0b9b678e3aed58f885bf94ef7d43fd1a968063014339df1e2e7cbe83826cd219cfd8a683b1f8aa")!),
            (name: "img",
             ext: "png",
             sha256: SHADigest(hexString: "bce3baf6096b028777adeea5d0496be0ee3a0a0b98a3fc6d897bab7b45d459a6")!,
             sha512: SHADigest(hexString: "72807448cd9d847fe47361eeb11784f7d5865cf0c29c5d01779205638a1bcfa619b746a24cd15ed6734f19f0ad813b98d3474e2eff679a13735417b0d8d6067c")!)
        ]
        
        func url(name: String, ext: String) -> URL? {
            guard let url = Bundle(for: type(of: self)).url(forResource: name, withExtension: ext) else {
                return nil
            }
            return url
        }

        func testHashDataWithKnownValues() {
            
            tests.forEach { test in
                
                guard let url = url(name: test.name, ext: test.ext),
                    let fileData = try? Data(contentsOf: url) else { XCTAssert(false, "Unable to get test file"); return }
                
                let sha256 = SHAAlgorithm.sha256.hash(data: fileData)
                let sha512 = SHAAlgorithm.sha512.hash(data: fileData)
                
                let reference256 = Data(SHA256.hash(data: fileData))
                let reference512 = Data(SHA512.hash(data: fileData))
                
                XCTAssertEqual(sha256, reference256)
                XCTAssertEqual(sha512, reference512)
                
    //            let dataCompare = {
    //                let _ = test.sha512.data == sha512.data
    //            }
    //
    //            let stringCompare = {
    //                let _ = test.sha512.hex == sha512.hex
    //            }
    //
    //            let dataTime = time(count: 1000, operation: dataCompare)
    //            let stringTime = time(count: 1000, operation: stringCompare)
    //
    //            print("Data: \(dataTime) | String: \(stringTime)")
                
            }
            
        }
        
    //    func testComparisonPerformance() {
    //
    //        let test = tests.first!
    //
    //        guard let url = url(name: test.name, ext: test.ext),
    //            let fileData = try? Data(contentsOf: url) else { XCTAssert(false, "Unable to get test file"); return }
    //
    //        let reference512 = Data(SHA512.hash(data: fileData))
    //        let sha = SHADigest(hexString: reference512.hex)!
    //
    //        let isEqualTest = {
    //
    //            let digest = SHA512.hash(data: fileData)
    //            let _ = sha.isEqual(to: digest)
    //
    //        }
    //
    //        let createShaTest = {
    //
    //            let createdSha = SHAAlgorithm.sha512.sha(data: fileData)
    //            let _ = createdSha == sha
    //
    //        }
    //
    //        let isEqualTime = time(count: 1000, operation: isEqualTest)
    //        let createTime = time(count: 1000, operation: createShaTest)
    //
    //        print("IsEqual: \(isEqualTime)| CreateSHA: \(createTime)")
    //
    //    }
        
        func testHashUrlWithKnownValues() {
            
            tests.forEach { test in
                
                guard let url = url(name: test.name, ext: test.ext) else {
                    XCTAssert(false, "Unable to get test url")
                    return
                }
                
                let sha256 = SHAAlgorithm.sha256.hash(url: url)
                let sha512 = SHAAlgorithm.sha512.hash(url: url)
                
                let fileData = try! Data(contentsOf: url)
                
                let reference256 = Data(SHA256.hash(data: fileData))
                let reference512 = Data(SHA512.hash(data: fileData))
                
                XCTAssertEqual(sha256, reference256)
                XCTAssertEqual(sha512, reference512)
                
            }
            
        }
        
        func testEquality() {
            
            XCTAssertEqual(SHAAlgorithm.sha256, SHAAlgorithm.sha256)
            XCTAssertEqual(SHAAlgorithm.sha512, SHAAlgorithm.sha512)
            XCTAssertNotEqual(SHAAlgorithm.sha256, SHAAlgorithm.sha512)
        }
        
        func testHashUrl() {
            
            tests.forEach { test in
                
                guard let url = url(name: test.name, ext: test.ext) else {
                    XCTAssert(false, "Unable to find test file url")
                    return
                }
                
                guard let sha256 = SHAAlgorithm.sha256.hash(url: url),
                    let sha512 = SHAAlgorithm.sha512.hash(url: url) else {
                        XCTAssert(false, "Did not return hash")
                        return
                }
                
                XCTAssertTrue(test.sha256.isEqual(toDigest: sha256))
                XCTAssertTrue(test.sha512.isEqual(toDigest: sha512))
                
            }
            
        }

}
