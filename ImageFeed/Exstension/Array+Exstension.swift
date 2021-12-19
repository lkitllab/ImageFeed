//
//  Array+Exstension.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import Foundation

extension Array {
    
    func elements(at index: Int, offset: Int) -> Self {
        guard endIndex != 0 else {return self}
        let start = index - offset < 0 ? 0 : index - offset
        let end = index + offset < endIndex ? index + offset : endIndex - 1
        return Array(self[start...end])
    }
}
