//
//  ChannlesSectionTableViewCell.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit
import Kingfisher
import ViewAnimator

class ChannlesSectionTableViewCell: UITableViewCell {
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var subDetailsLabel: UILabel!
    @IBOutlet weak var channelCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadingView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        channelCollectionView.register(SeriesCollectionViewCell.nib, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        channelCollectionView.register(CourseCollectionViewCell.nib, forCellWithReuseIdentifier: CourseCollectionViewCell.identifier)
        channelImageView.circular()
    }
    var channelSectionViewModel: ChannelSectionViewModel? {
        didSet {
            loadingView.isHidden = channelSectionViewModel?.itemsCount != 0
            collectionViewHeightConstraint.constant = CGFloat(sectionHeight)
            if let channelSectionViewModel = channelSectionViewModel {
                if let thumbnailUrl = channelSectionViewModel.thumbnailUrl {
                    channelImageView.kf.setImage(with: thumbnailUrl)
                }
                channelNameLabel.text = channelSectionViewModel.title
                subDetailsLabel.text = channelSectionViewModel.subdetails
                channelCollectionView.reloadData()
            }
        }
    }
    var sectionHeight: Int {
        let itemsCount = channelSectionViewModel?.itemsCount ?? 0
        let reminder = itemsCount % 6
        let rowsCount = itemsCount / 6 + ( reminder > 0 ? 1 : 0 )
        let cellHeight = (channelSectionViewModel?.isSeries ?? false) ? 234 : 381
        return rowsCount * cellHeight
    }
}

extension ChannlesSectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if channelSectionViewModel?.isSeries ?? false {
            return CGSize(width: 340, height: 234)
        }
        return CGSize(width: 182, height: 381)
    }
}

extension ChannlesSectionTableViewCell: UICollectionViewDelegate {
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

extension ChannlesSectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        channelSectionViewModel?.itemsCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let channelSectionViewModel = channelSectionViewModel else { return UICollectionViewCell() }
        if channelSectionViewModel.isSeries {
            if let seriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.identifier, for: indexPath) as? SeriesCollectionViewCell,
                let seriesViewModel = channelSectionViewModel.seriesViewModels?[indexPath.row] {
                seriesCell.seriesViewModel = seriesViewModel
                return seriesCell
            }
        } else {
            if let courseCell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseCollectionViewCell.identifier, for: indexPath) as? CourseCollectionViewCell,
                let courseViewModel = channelSectionViewModel.coursesViewModels?[indexPath.row] {
                courseCell.courseViewModel = courseViewModel
                return courseCell
            }
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
