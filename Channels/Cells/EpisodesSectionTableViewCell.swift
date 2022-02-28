//
//  EpisodesSectionTableViewCell.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit
import ViewAnimator

class EpisodesSectionTableViewCell: UITableViewCell {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    var episodeSectionViewModel: EpisodesSectionViewModel? {
        didSet {
            let episodesCount = episodeSectionViewModel?.episodesCount ?? 0
            loadingView.isHidden = episodesCount != 0
            if episodesCount > 0 {
                episodesCollectionView.reloadData()
                collectionHeightConstraint.constant = CGFloat(sectionHeight)
            }
        }
    }
    var sectionHeight: Int {
        let episodesCount = episodeSectionViewModel?.episodesCount ?? 0
        let reminder = episodesCount % 6
        let rowsCount = episodesCount / 6 + ( reminder > 0 ? 1 : 0 )
        return rowsCount * 381
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        episodesCollectionView.register(CourseCollectionViewCell.nib, forCellWithReuseIdentifier: CourseCollectionViewCell.identifier)
    }
}

extension EpisodesSectionTableViewCell: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            let action = UIAction(title: "Watch") { (_) in
            }
            let addToFavoriteAction =  UIAction(title: "Add To Favorite") { (_) in
            }
            return UIMenu(title: "", image: nil, identifier: UIMenu.Identifier(rawValue: "Menu"), options: [], children: [action, addToFavoriteAction])
        }
        return configuration
    }
}

extension EpisodesSectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodeSectionViewModel?.episodesCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let courseCell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseCollectionViewCell.identifier, for: indexPath) as? CourseCollectionViewCell,
            let courseViewModel = episodeSectionViewModel?.episodesViewModels?[indexPath.row] {
            courseCell.courseViewModel = courseViewModel
            return courseCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
        UIView.animate(views: [cell.contentView], animations: [fromAnimation, zoomAnimation, rotateAnimation], duration: 0.5)
    }
}
