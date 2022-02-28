//
//  CategoryCollectionViewCell.swift
//  Channels
//
//  Created by Mohamed Adly on 5/25/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    var categoryViewModel: CategoryViewModel! {
        didSet {
            nameLabel.text = categoryViewModel.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.roundedCorner(radius: 30, borderWidth: 0, borderColor: .clear)
    }
}
