//
//  Extension+UINib.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 18/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import UIKit
extension UINib {
    /// LoadNib
    ///
    /// - Parameter nibName: NibName
    /// - Returns: UINib
    static public func loadNib(named nibName: NibName) -> UINib {
        return UINib(nibName: nibName.rawValue, bundle: Bundle.main)
    }
}
