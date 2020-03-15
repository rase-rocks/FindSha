//
//  NSDataHexString.swift
//  FindSha
//
//  Created by Robert Atherton on 22/03/2019.
//  Copyright © 2019 Robert Atherton. All rights reserved.
//

import Foundation

extension NSData {
    
    var hexString: String {
        var bytes       = [UInt8](repeating: 0, count: self.length)
        self.getBytes(&bytes, length: self.length)
        
        var hexString   = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
}
