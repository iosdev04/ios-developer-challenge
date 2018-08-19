//
//  ErrorStatus.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
struct ErrorStatus: Decodable {
    let code: String
    let message: String
}
// MARK: - ErrorStatus
extension ErrorStatus {
    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }
    /// Decoding Response
    ///
    /// - Parameter decoder: Decoder
    /// - Throws: Error
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
    }
}
