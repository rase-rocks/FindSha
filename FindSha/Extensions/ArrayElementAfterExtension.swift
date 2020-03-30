import Foundation

extension Array {
    
    func element(after index: Int) -> Element? {
        
        guard index >= 0 && index < count else {
            return nil
        }
        
        return self[index + 1]
    }
    
}
