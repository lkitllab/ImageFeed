//
//  ImageCellModel.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import Foundation
import Combine
import UIKit

class ImageCellModel {
    
    let item: ImageDownloadItem
    
    @Published var image: UIImage?
    
    @Published var likes: String?
    @Published var downloads: String?
    @Published var views: String?
    
    var size: CGSize = .zero
    
    private var cancellables = Set<AnyCancellable>()
    
    init(item: UnsplashItem) {
        
        self.item = ImageDownloadItem(item: item)
        self.size = .init(width: CGFloat(item.width), height: CGFloat(item.height))
        
        self.likes = "Likes: \(item.likesCount)"
        let dText = item.downloadsCount == nil ? "none" : "\(item.downloadsCount!)"
        self.downloads = "Downloads: " + dText
        let vText = item.viewsCount == nil ? "none" : "\(item.viewsCount!)"
        self.views = "Views: " + vText
    }
    
    func clear() {
        item.image = nil
    }
}
