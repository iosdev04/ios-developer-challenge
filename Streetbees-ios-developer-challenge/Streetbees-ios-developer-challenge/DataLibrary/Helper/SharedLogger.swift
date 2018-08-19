//
//  SharedLogger.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation

public final class SharedLogger {
    private static let loggingQueue: DispatchQueue = {
        let createdQueue: DispatchQueue
        let backgroundQueue = DispatchQueue.global(qos: .background)
        createdQueue = DispatchQueue(label: "com.dispatchLoggingQueue.Logdata",
                                     attributes: [], target: backgroundQueue)
        return createdQueue
    }()
    /// Logging Error Message to console
    ///
    /// - Parameter message: String
    public static func logError(_ message: String) {
        if !SharedLogger.isLogEnabled() {
            return
        }
        loggingQueue.async {
            print("*********** Error *********** : \(message)")
        }
    }
    /// Logging Info to console
    ///
    /// - Parameter message: String
    public static func logInfo(_ message: String) {
        if !SharedLogger.isLogEnabled() {
            return
        }
        loggingQueue.async {
            print(message)
        }
    }
    //This method is used to enabled and disabled log when releasing the app for test or apple store
    public static func isLogEnabled() -> Bool {
        return true
    }
    /// Loging Error
    ///
    /// - Parameter error: Error
    public static func logException(_ error: Error) {
        loggingQueue.async {
            print((error as NSError).localizedDescription)
        }
    }
}
