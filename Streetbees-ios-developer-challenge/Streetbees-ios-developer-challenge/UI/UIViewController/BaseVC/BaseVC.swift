//
//  BaseVC.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 18/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//
import UIKit
class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// Prepare Segue
    ///
    /// - Parameters:
    ///   - segue: segue
    ///   - sender: sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier! {
        case StoryboardIdentity.comicDetailsVC.rawValue:
            if let comicDetailsVC = segue.destination as? ComicDetailsVC,
                let selectedComic = sender as? Result {
                comicDetailsVC.selectedComic = selectedComic
            }
        default:
            break
        }
    }
    /// <#Description#>
    ///
    /// - Parameter block: <#block description#>
    func UI(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - delay: <#delay description#>
    ///   - closure: <#closure description#>
    func delay(delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}
