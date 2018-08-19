//
//  ComicViewModel.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 18/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation

final class ComicViewModel {
    var downloadMore = true
    let limit: Int
    var offset: Int
    var comics: [Result] = []
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
    /// <#Description#>
    ///
    /// - Parameter completion: <#completion description#>
    func fetchComics(completion: @escaping () -> Void) {
        let comic = ComicRequest(endpoint: .comics, limit: limit, offset: offset)
        let data = ComicService(withRequest: comic)
        data.fetchComicList { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let dataResponse):
                guard let dataResponse = dataResponse, dataResponse.data.results.count > 0 else {
                    strongSelf.downloadMore = false
                    return
                }
                strongSelf.comics.append(contentsOf: dataResponse.data.results)
                strongSelf.offset += 1
            case .failure(let error):
                SharedLogger.logError(error.localizedDescription)
                strongSelf.downloadMore = false
            }
            completion()
        }
    }
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func numberOfRows() -> Int {
        return comics.count
    }
    /// <#Description#>
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    func comic(at index: Int) -> Result {
        return comics[index]
    }
}
