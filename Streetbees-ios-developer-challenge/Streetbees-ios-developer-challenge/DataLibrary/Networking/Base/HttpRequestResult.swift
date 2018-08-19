//
//  HttpRequestResult.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
public enum HttpRequestResult<T, U> {
    case success(T)
    case failure(U)
}
