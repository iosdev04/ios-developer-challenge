//
//  Comic.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
struct Comic: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: FetchProperties
}

struct FetchProperties: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

struct Result: Codable {
    let itemId: Int
    let title: String
    let itemDescription: String?
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let resourceURI: String
    private enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case title, thumbnail, resourceURI, images
        case itemDescription = "description"
    }
}

struct Thumbnail: Codable {
    let path, thumbnailExtension: String
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum StandardImageVariants: String {
    //Standard (square) aspect ratio
    case fullSize = "."
    case detail = "detail"
    case small = "portrait_small"
    case medium = "portrait_medium"
    //case large = "standard_large"
    case xlarge = "portrait_xlarge"
    case fantastic = "portrait_fantastic"
    case uncanny = "portrait_uncanny"
    case incredible = "portrait_incredible"
    /// GetImageURLFor
    ///
    /// - Parameter thumbnail: thumbnail
    /// - Returns: URL
    func getImageURLFor(thumbnail: Thumbnail) -> URL? {
        if self == .fullSize {
            if let imageURL = URL(string: "\(thumbnail.path).\(thumbnail.thumbnailExtension)") {
                return imageURL
            }
        }
        if let imageURL = URL(string: "\(thumbnail.path)/\(self.rawValue).\(thumbnail.thumbnailExtension)") {
            return imageURL
        }
        return nil
    }
}
