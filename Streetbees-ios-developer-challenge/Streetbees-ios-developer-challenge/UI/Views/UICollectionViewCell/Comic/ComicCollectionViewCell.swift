//
//  ComicCollectionViewCell.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 18/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import UIKit
import Kingfisher

class ComicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var currentComic: Result? {
        didSet {
            if let entity = currentComic {
                //https://developer.marvel.com/documentation/images
                //As per above documentation. Multiple size can be downloaded from server.
                //For more details visit the above link
                if let imageURL = StandardImageVariants.medium.getImageURLFor(thumbnail: entity.thumbnail) {
                    imageView.kf.setImage(with: imageURL,
                                                   placeholder: nil,
                                                   options: nil,
                                                   progressBlock: nil) { [weak self] (downloadedImage: UIImage?, _, _, _) in
                                                    if let displayImage = downloadedImage {
                                                        self?.imageView.image = displayImage
                                                    }
                    }
                }
            } else {
                imageView.image = nil
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
    }

}
