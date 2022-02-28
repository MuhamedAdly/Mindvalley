//
//  CategoriesSectionTableViewCell.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit
import ViewAnimator

class CategoriesSectionTableViewCell: UITableViewCell {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeghtConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadingView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoriesCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    var categoriesViewModel: CategoriesSectionViewModel! {
        didSet {
            loadingView.isHidden = categoriesViewModel.categoriesCount > 0
            if categoriesViewModel.categoriesCount > 0 {
                categoriesCollectionView.reloadData()
                collectionHeghtConstraint.constant = CGFloat(sectionHeight)
            } else {
                collectionHeghtConstraint.constant = 212
            }
            setNeedsLayout()
        }
    }
    var sectionHeight: Int {
        let totalItemsWidth = categoriesViewModel.categoriesCount * 175 // cellWidth = 160, space = 15
        let rowWidth = Int(categoriesCollectionView.bounds.width)
        let rowsReminders = totalItemsWidth % rowWidth
        var numberOfRows = Int(totalItemsWidth / rowWidth)
        if rowsReminders > 0 {
            numberOfRows += 1
        }
        return numberOfRows * 75 // cellHeight = 60, space = 15
    }
}

extension CategoriesSectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoriesViewModel.categoriesCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell,
            let categoryViewModel = categoriesViewModel.categorieViewModels?[indexPath.row] {
            categoryCell.categoryViewModel = categoryViewModel
            return categoryCell
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
