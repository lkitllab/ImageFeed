//
//  ImageDownloader.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import UIKit

class ImageDownloader: Operation {
    
    let item: ImageDownloadItem
    
    init(_ item: ImageDownloadItem) {
        self.item = item
    }
    
    override func main() {
        
        if isCancelled {
            return
        }
        
        guard let imageData = try? Data(contentsOf: item.url) else {
            return
        }
        
        if !imageData.isEmpty {
            item.image = UIImage(data:imageData)
            item.state = .downloaded
        } else {
            item.state = .failed
        }
    }
}
