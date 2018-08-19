//
//  ComicVC.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 18/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import UIKit

class ComicVC: BaseVC {
    lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 20
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        collectionViewFlowLayout.scrollDirection = .horizontal
        return collectionViewFlowLayout
    }()
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib.loadNib(named: .comic),
                               forCellWithReuseIdentifier: CollectionCellReuseIdentifier.comic.rawValue)
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: false)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.accessibilityLabel = AccessibilityLabel.comicCollectionView.rawValue
        }
    }
    private let comicViewModel = ComicViewModel(limit: 50, offset: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showLoader()
        getdata()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    private func getdata() {
        comicViewModel.fetchComics { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.hideLoader()
            strongSelf.UI {
                strongSelf.collectionView.reloadData()
            }
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ComicVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 0, height: 0)
        }
        let noOfRows: CGFloat = collectionView.frame.height > collectionView.frame.width ? 4 : 2
        let cellHeight = (collectionView.frame.height / noOfRows) - flowLayout.minimumLineSpacing
        let cellWidth = cellHeight / 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
// MARK: - UICollectionViewDataSource
extension ComicVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicViewModel.numberOfRows()
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionCellReuseIdentifier.comic.rawValue, for: indexPath)
            as? ComicCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.currentComic = comicViewModel.comic(at: indexPath.item)
        cell.accessibilityLabel = "\(AccessibilityLabel.comicCollectionCellView.rawValue)-\(indexPath.item)"
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension ComicVC: UICollectionViewDelegate {
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - cell: <#cell description#>
    ///   - indexPath: <#indexPath description#>
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = comicViewModel.numberOfRows() - 25
        if indexPath.row == lastItem  && comicViewModel.downloadMore == true {
            getdata()
        }
    }
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - indexPath: <#indexPath description#>
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: StoryboardIdentity.comicDetailsVC.rawValue,
                     sender: comicViewModel.comic(at: indexPath.item))
    }
}
