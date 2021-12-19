//
//  UnsplashItem.swift
//  ImageFeed
//
//  Created by Kit on 19.12.21.
//

import Foundation

public struct UnsplashItem: Codable {

    public enum URLKind: String, Codable {
        case raw
        case full
        case regular
        case small
        case thumb
    }

    public enum LinkKind: String, Codable {
        case own = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }

    public let identifier: String
    public let height: Int
    public let width: Int
    public let urls: [String: URL]
    public let links: [String: URL]
    public let likesCount: Int
    public let downloadsCount: Int?
    public let viewsCount: Int?

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case height
        case width
        case color
        case urls
        case links
        case likesCount = "likes"
        case downloadsCount = "downloads"
        case viewsCount = "views"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)

        likesCount = try container.decode(Int.self, forKey: .likesCount)
        downloadsCount = try? container.decode(Int.self, forKey: .downloadsCount)
        viewsCount = try? container.decode(Int.self, forKey: .viewsCount)
        urls = try container.decode([String: URL].self, forKey: .urls)
        links = try container.decode([String: URL].self, forKey: .links)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(height, forKey: .height)
        try container.encode(width, forKey: .width)
        try container.encode(urls.convert({ ($0.key, $0.value.absoluteString) }), forKey: .urls)
        try container.encode(links.convert({ ($0.key, $0.value.absoluteString) }), forKey: .links)
        try container.encode(likesCount, forKey: .likesCount)
        try? container.encode(downloadsCount, forKey: .downloadsCount)
        try? container.encode(viewsCount, forKey: .viewsCount)
    }

}
