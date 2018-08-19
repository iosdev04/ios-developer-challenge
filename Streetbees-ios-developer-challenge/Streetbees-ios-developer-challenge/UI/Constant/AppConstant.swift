//
//  AppConstant.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 18/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
public enum AccessibilityLabel: String {
    case comicCollectionView = "ComicCollectionViewAccessibility"
    case comicCollectionCellView = "comicCollectionCellViewAccessibility"
    case comicDetailsBlurView = "comicDetailsBlurViewAccessibility"
    case comicDetailsbarDoneItem = "comicDetailsbarDoneItemAccessibility"
}

public enum NibName: String {
    case comic = "ComicCollectionViewCell"
}

public enum CollectionCellReuseIdentifier: String {
    case comic = "ComicCollectionViewCellReuseIdentifier"
}

public enum StoryboardName: String {
    case main = "Main"
}

public enum StoryboardIdentity: String {
    case comicVC = "ComicVC"
    case comicDetailsVC = "ComicDetails"
}
