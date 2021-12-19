//
//  ImageCellModel.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import UIKit
import Combine

class ImageCellModel {
    
    let item: ImageDownloadItem
    
    @Published var image: UIImage?
    
    @Published var likes: String?
    @Published var downloads: String?
    @Published var views: String?
    

    init(item: UnsplashItem) {
        
        self.item = ImageDownloadItem(item: item)
    }

    
}
