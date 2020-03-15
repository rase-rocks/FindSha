//
//  ArrayElementAfterExtension.swift
//  FindSha
//
//  Created by Robert Atherton on 22/03/2019.
//  Copyright © 2019 Robert Atherton. All rights reserved.
//

import Foundation

extension Array {
    
    func element(after index: Int) -> Element? {
        
        guard index >= 0 && index < count else {
            return nil
        }
        
        return self[index + 1]
    }
    
}
