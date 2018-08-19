//
//  SharedUtils.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
open class SharedUtils {
    private init() { }
    /// Return non-optional string
    ///
    /// - Parameter value: Optional String
    /// - Returns: String
    static func extractStringValue(_ value: String?) -> String {
        if let str = value {
            return str
        }
        return ""
    }
    /// <#Description#>
    static func getTimestampWithHash() -> (currentTimestamp: Int64?, hash: String?) {
        let timeStamp = Date().toMillis()
        //Server-side applications must pass two parameters in addition to the apikey parameter:
        //ts - a timestamp (or other long string which can change on a request-by-request basis)
        //hash - a md5 digest of the ts parameter,
        //your private key and your public key (e.g. md5(ts+privateKey+publicKey)
        if let hash = ("\(timeStamp!)" + APIConstant.privateKey + APIConstant.publicKey).MD5() {
            return (currentTimestamp: timeStamp!, hash: hash)
        }
        return (currentTimestamp: nil, hash: nil)
    }
}
