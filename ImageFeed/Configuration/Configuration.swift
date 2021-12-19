//
//  Configuration.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import Foundation

public struct UnsplashConfiguration {
    
    let path = "https://api.unsplash.com"
    
    let accessKey = "yQIlb3VwpZWl7Hzt74ZK-pcWrBBOJ53AysEdbVy1ahs"
    let secretKey = "q4M0actpqPrS2quLvwQCazY6Qj_mshaSiLZd0jeFY84"
    
    var itemsPerPage = 20
}

struct Configuration {
    static var shared = UnsplashConfiguration()
}
