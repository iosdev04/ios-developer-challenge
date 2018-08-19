//
//  HttpRequestError.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
enum HttpRequestError: Error {
    case exception(error: Error?)
    case message(message: String)
    case responseError(errorStatus: ErrorStatus?)
}
extension HttpRequestError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .exception(let error):
            if let decoding = error as? DecodingError {
                SharedLogger.logException(decoding)
                return decoding.localizedDescription
            }
            if let error = error {
                return error.localizedDescription
            }
            return "No error message"
        case .responseError(let errorStatus):
            if let errorStatus = errorStatus {
                return errorStatus.message
            }
            return "No error message"
        case .message(let message):
            return message
        }
    }
}
