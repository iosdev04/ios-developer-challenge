//
//  ComicService.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
public enum ComicEndpoint {
    case comics
    case other
}
extension ComicEndpoint: HttpEndpoint {
    var path: String {
        switch self {
        case .comics: return "comics"
        case .other: return "InvalidPath"
        }
    }
}

public struct ComicRequest: BaseClientRequest {
    let comicEndpoint: ComicEndpoint
    fileprivate let limit: Int
    fileprivate let offset: Int
    /// Init request with endpoint
    ///
    /// - Parameter endpoint: ComicEndpoint
    public init(endpoint: ComicEndpoint, limit: Int, offset: Int) {
        comicEndpoint = endpoint
        self.limit = limit
        self.offset = offset
    }
}

class ComicService: HttpRequest {
    var query: HttpRequestQueryType {
        return .path
    }
    var session: URLSession {
        return URLSession(configuration: .ephemeral)
    }
    var parameters: [String: Any]? {
        let timestampHash = SharedUtils.getTimestampWithHash()
        if let timestamp = timestampHash.currentTimestamp, let hash = timestampHash.hash {
            return  ["ts": timestamp,
                     "hash": hash,
                     "limit": comicRequest.limit,
                     "offset": comicRequest.offset * comicRequest.limit
            ]
        }
        return nil
    }
    ///desired Response Type
    typealias ResponseObject = Comic
    internal let endpoint: HttpEndpoint
    private let comicRequest: ComicRequest
    /// Initialize service with request
    ///
    /// - Parameter request: ComicRequest
    init(withRequest request: ComicRequest) {
        comicRequest = request
        endpoint = request.comicEndpoint
    }
    /// fetchComicList
    ///
    /// - Parameter completion: HttpRequestResult<ResponseObject?, HttpRequestError>
    func fetchComicList(completion: @escaping (HttpRequestResult<ResponseObject?, HttpRequestError>) -> Void) {
        sendRequest(decode: { json -> ResponseObject? in
            guard let result = json as? ResponseObject else { return  nil }
            return result
        }, completion: completion)
    }
}
