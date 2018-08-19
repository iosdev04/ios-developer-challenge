//
//  Extension+Strig.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import UIKit
extension String {
    /// Get MD5 for given string
    ///
    /// - Returns: Hash String or nil if data is invalid
    func MD5() -> String? {
        guard let dataString = data(using: .utf8) else {
            return nil
        }
        return dataString.md5String
    }
}
