//
//  ImageProvider.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import Foundation

class ImageProvider {
    
    lazy var downloadsInProgress: [URL: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    
    func startDownload(for item: ImageDownloadItem) {
        
        guard downloadsInProgress[item.url] == nil else {
            return
        }
        
        let downloader = ImageDownloader(item)
        
        downloader.completionBlock = {
            DispatchQueue.main.async {
                self.downloadsInProgress.removeValue(forKey: item.url)
            }
        }
        
        downloadsInProgress[item.url] = downloader
        downloadQueue.addOperation(downloader)
    }
}
