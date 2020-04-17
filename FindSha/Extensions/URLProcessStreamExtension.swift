import Foundation

extension URL {
    
    func process(with hasBytesHandler: (UnsafeRawBufferPointer) -> Void) {
        
        guard let stream = InputStream(url: self) else { return }
        
        stream.open()
        
        let bufferSize  = 512
        let buffer      = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        
        while stream.hasBytesAvailable {
            
            let read            = stream.read(buffer, maxLength: bufferSize)
            if read > 0 {
                let bufferPointer   = UnsafeRawBufferPointer(start  : buffer,
                                                             count  : read)
                hasBytesHandler(bufferPointer)
            }
            
        }
        
        stream.close()
        
    }
    
}
