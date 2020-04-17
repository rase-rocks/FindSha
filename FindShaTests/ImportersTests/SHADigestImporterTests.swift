import XCTest

class SHAImporterTests: XCTestCase {

    func textData(fromName name: String, ext: String) -> Data? {
        
        guard let url = Bundle(for: type(of: self)).url(forResource: name, withExtension: ext),
            let data = try? Data(contentsOf: url) else {
                XCTAssert(false, "Missing test file")
                return nil
        }
        
        return data
        
    }
    
    func testImportTextFile() {
        
        guard let data = textData(fromName: "shas", ext: "txt") else {
            XCTAssert(false, "Did not get file")
            return
        }
        
        let shas = SHADigestImporter.shas(from: data)
        
        XCTAssertEqual(shas.count, 3)
        
        guard shas.count == 3 else { return }
        
        XCTAssertEqual(shas[0].algorithm, .sha512)
        XCTAssertEqual(shas[1].algorithm, .sha512)
        XCTAssertEqual(shas[2].algorithm, .sha256)
        
        XCTAssertEqual(shas[2].hex, "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782")
        
    }
    
    func testImportMessyTextFile() {
        
        guard let data = textData(fromName: "shas-messy", ext: "txt") else {
            XCTAssert(false, "Did not get file")
            return
        }
        
        let shas = SHADigestImporter.shas(from: data)
        
        XCTAssertEqual(shas.count, 3)
        
        guard shas.count == 3 else { return }
        
        let expectedSHAs = [
            "124cfa43ecacbd72401439dd1a30bbd53b2da278adc64bdfee0b9b678e3aed58f885bf94ef7d43fd1a968063014339df1e2e7cbe83826cd219cfd8a683b1f8aa",
            "f6abe2df2165d12d45c0d2ed2f25526f88e6c2001ef5d336b9a3b0ed561d27baa043b8ebf859c31bd0f94b169d2ce93013027282add676d8ce5ecc8d6302c67e",
            "5e03adcee1eef601ff3c9030a9edfdc4735a73188701eae303394edbff6ef782"
            ].compactMap { SHADigest(hexString: $0) }
        
        expectedSHAs.enumerated().forEach { (offset, sha) in
            
            let importedSha = shas[offset]
            
            XCTAssertEqual(importedSha, sha)
            
        }
        
    }
    
    func testImportCSVFile() {
     
        guard let data = textData(fromName: "shas", ext: "csv") else {
            XCTAssert(false, "Did not get file")
            return
        }
        
        let shas = SHADigestImporter.shas(from: data)
        
        let expectedCount = 2
        
        XCTAssertEqual(shas.count, expectedCount)
        
        guard shas.count == expectedCount else { return }
        
        let expectedSHAs = [
            "bce3baf6096b028777adeea5d0496be0ee3a0a0b98a3fc6d897bab7b45d459a6",
            "6579ea6175313eec2ce0f343c5db52d969d42b88d43adcb2c75f90a0ecc3b90c"
        ].compactMap { SHADigest(hexString: $0) }
        
        expectedSHAs.enumerated().forEach { (offset, sha) in
            
            let importedSha = shas[offset]
            
            XCTAssertEqual(importedSha, sha)
            
        }
        
    }
    
    func testImportCSVFileMixed() {
        
        guard let data = textData(fromName: "shas-mixed", ext: "csv") else {
            XCTAssert(false, "Did not get file")
            return
        }
        
        let shas = SHADigestImporter.shas(from: data)
        
        let expectedCount = 4
        
        XCTAssertEqual(shas.count, expectedCount)
        
        guard shas.count == expectedCount else { return }
        
        let expectedSHAs = [
            SHADigest(hexString: "bce3baf6096b028777adeea5d0496be0ee3a0a0b98a3fc6d897bab7b45d459a6")!,
            SHADigest(hexString: "124cfa43ecacbd72401439dd1a30bbd53b2da278adc64bdfee0b9b678e3aed58f885bf94ef7d43fd1a968063014339df1e2e7cbe83826cd219cfd8a683b1f8aa")!,
            SHADigest(hexString: "6579ea6175313eec2ce0f343c5db52d969d42b88d43adcb2c75f90a0ecc3b90c")!,
            SHADigest(hexString: "f6abe2df2165d12d45c0d2ed2f25526f88e6c2001ef5d336b9a3b0ed561d27baa043b8ebf859c31bd0f94b169d2ce93013027282add676d8ce5ecc8d6302c67e")!
        ]
        
        expectedSHAs.forEach { sha in
            XCTAssertTrue(shas.contains(sha))
        }
        
    }
    
    func testImportFromEmpty() {
        
        let data = Data()
        let string = ""
        
        let shaData = SHADigestImporter.shas(from: data)
        let shaString = SHADigestImporter.shas(from: string)
        
        XCTAssertTrue(shaData.isEmpty)
        XCTAssertTrue(shaString.isEmpty)
        
    }

}
