//
//  ComicDetailsVC.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 18/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import UIKit
import Kingfisher
class ComicDetailsVC: BaseVC {

    @IBOutlet weak var barDoneItem: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var blurDescriptionView: UIVisualEffectView!
    var selectedComic: Result!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let imageURL = StandardImageVariants.fullSize.getImageURLFor(thumbnail: selectedComic.thumbnail) {
            imageView.kf.setImage(with: imageURL,
                                  placeholder: nil,
                                  options: nil,
                                  progressBlock: nil) { [weak self] (downloadedImage: UIImage?, _, _, _) in
                                    if let displayImage = downloadedImage {
                                        self?.imageView.image = displayImage
                                    }
            }
        }
        blurDescriptionView.accessibilityIdentifier = AccessibilityLabel.comicDetailsBlurView.rawValue
        barDoneItem.accessibilityIdentifier = AccessibilityLabel.comicDetailsbarDoneItem.rawValue
        
        textViewDescription.backgroundColor = .clear
        lblTitle.text = selectedComic.title
        let attributedStringColor = [NSAttributedStringKey.foregroundColor: UIColor.white,
                                     NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0)
        ]
        textViewDescription.attributedText = NSAttributedString(string: selectedComic.itemDescription ??
            "No Description Available.", attributes: attributedStringColor)
        delay(delay: 3) {
            UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 1,
                           initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blurDescriptionView.isHidden = false
            }, completion: nil)
        }
    }
    @IBAction func btnDoneTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true) {
        }
    }
}
