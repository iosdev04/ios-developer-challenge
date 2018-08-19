//
//  Extension+Data.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
extension Data {
    var md5String: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        var digestHex = ""
        withUnsafeBytes { (bytes: UnsafePointer<CChar>) -> Void in
            CC_MD5(bytes, CC_LONG(self.count), &digest)
            for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
                digestHex += String(format: "%02x", digest[index])
            }
        }
        return digestHex
    }
}
