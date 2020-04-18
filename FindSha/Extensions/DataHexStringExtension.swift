import Foundation

extension Data {
    
    init?(hexString: String) {
        
        let len     = hexString.count / 2
        var data    = Data(capacity: len)
        
        for i in 0..<len {
            
            let j       = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k       = hexString.index(j, offsetBy: 2)
            let bytes   = hexString[j..<k]
            
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
            
        }
        
        self = data
        
    }
    
    var hex: String {
        
        var hexString   = ""
        for byte in self {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
        
    }
    
}
