//
//  ImageRecord.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import UIKit

enum ImageDownloadItemState {
    case new, downloaded, failed
}

class ImageDownloadItem {
    
    let name: String
    let url: URL
    var state = ImageDownloadItemState.new
    
    @Published var image: UIImage?
    
    init(name:String, url:URL) {
        self.name = name
        self.url = url
    }
}

extension ImageDownloadItem {
    convenience init(item: UnsplashItem) {
        self.init(name: item.identifier, url: item.urls[UnsplashItem.URLKind.small.rawValue]!)
    }
}
