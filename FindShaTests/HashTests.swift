//
//  HashTests.swift
//  FindShaTests
//
//  Created by Robert Atherton on 15/03/2020.
//  Copyright © 2020 Robert Atherton. All rights reserved.
//

import XCTest

struct HashTestFile {
    let name        : String
    let ext         : String
    let sha256      : String
    let sha512      : String
}

class HashTests: XCTestCase {

    // Hashes generated using OpenSSL
    
    let td256       = "fb9aba363fa983289cae41a93a0986db68a69cf58bc5c4bed17f0a047b2be0f2"
    let tMDd256     = "52348792707a57ed7f42e46ecf58573dd424afa1fe725873000fdca31a24721c"
    let empty256    = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    
    let td512       = "3bb9aa49aa8c13c2da2b62854ecdd76da742be744ffcd5a647cf2749612677ffff4965ebce318fe564b03261458fcd72bbc7b1a3b87927cdccbd7a1baa5afaa6"
    let tMDd512     = "b4127c420d451a600dd653a4a58f574480d041381502640633372fd56a7ae2b22877691395ba6f85ecd1fc052a93000278c6d5499a8e59510d762c7e924dc776"
    let empty512    = "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e"
        
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func urlFor(resource: String, withExtension: String) -> URL? {
        return bundle.url(forResource: resource, withExtension: withExtension)
    }
    
    func testKnownDocuments() {
        
        let files = [
            HashTestFile(name: "text-document", ext: "pdf", sha256: td256, sha512: td512),
            HashTestFile(name: "text-markdown-document", ext: "md", sha256: tMDd256, sha512: tMDd512),
            HashTestFile(name: "empty", ext: "txt", sha256: empty256, sha512: empty512)
        ]
        
        files.forEach { file in
            
            guard let url   = urlFor(resource: file.name, withExtension: file.ext),
                let data    = NSData(contentsOf: url) else {
                    XCTAssert(false, "Could not find \(file.name)")
                    return
            }
            
            let sha256  = Hash.process(data: data, using: .sha256)
            let sha512  = Hash.process(data: data, using: .sha512)
            
            XCTAssertEqual(sha256, file.sha256)
            XCTAssertEqual(sha512, file.sha512)
            
        }
        
        
        
    }
    

}
