//
//  Extension+Date.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
extension Date {
    /// To get current Timestamp
    ///
    /// - Returns: Timestamp
    func toMillis() -> Int64! {
        return Int64(timeIntervalSince1970 * 1000)
    }
}
