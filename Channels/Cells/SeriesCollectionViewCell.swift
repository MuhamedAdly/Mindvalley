//
//  SeriesCollectionViewCell.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit
import Kingfisher

class SeriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var seriesImageView: UIImageView! {
        didSet {
        maskedImageView.roundedCorner(radius: 20, borderWidth: 0, borderColor: .clear)
        seriesImageView.mask = maskedImageView
        }
    }
    @IBOutlet weak var seriesTitleLabel: UILabel!
    @IBOutlet weak var blurredSeriesImageView: UIImageView!
    @IBOutlet weak var dropShadowView: UIView! {
        didSet {
            dropShadowView.addShadow(shadowColor: .black,
            offSet: CGSize(width: 3, height: 3), opacity: 0.5,
            shadowRadius: 5, cornerRadius: 20.0, corners: [.allCorners], fillColor: .clear)
        }
    }
    @IBOutlet weak var maskedImageView: UIView!
    var seriesViewModel: SeriesViewModel! {
        didSet {
            if let imageUrl = seriesViewModel.coverImageUrl {
                blurredSeriesImageView.kf.setImage(with: imageUrl)
                seriesImageView.kf.indicatorType = .activity
                seriesImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"), options: [.transition(.fade(0.2)), .cacheOriginalImage])
            } else {
                seriesImageView.image = UIImage(named: "placeholderImage")
                blurredSeriesImageView.image = UIImage(named: "placeholderImage")
            }
            seriesTitleLabel.text = seriesViewModel.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
