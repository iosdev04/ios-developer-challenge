//
//  Extension+UIViewController.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 18/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import UIKit

extension UIViewController {
    /// ShowLoader on the view
    public func showLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            ProgressView.sharedInstance.showLoader(strongSelf.view)
        }
    }
    /// HideLoader from the view
    public func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            ProgressView.sharedInstance.hideLoader()
        }
    }
}
