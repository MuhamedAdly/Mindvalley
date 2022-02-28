//
//  CourseCollectionViewCell.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit
import Kingfisher

class CourseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var subdetailsLabel: UILabel!
    @IBOutlet weak var maskImageView: UIView! {
        didSet {
            maskImageView.roundedCorner(radius: 20, borderWidth: 0, borderColor: .clear)
            courseImageView.mask = maskImageView
        }
    }
    @IBOutlet weak var blurredCourseImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            shadowView.addShadow(shadowColor: .black,
                                 offSet: CGSize(width: 3, height: 3), opacity: 0.5,
                                 shadowRadius: 5, cornerRadius: 20.0, corners: [.allCorners], fillColor: .clear)
        }
    }
    var courseViewModel: CourseViewModel! {
        didSet {
            if let imageUrl = courseViewModel.coverImageUrl {
                blurredCourseImageView.kf.setImage(with: imageUrl)
                courseImageView.kf.indicatorType = .activity
                courseImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"), options: [.transition(.fade(0.2)), .cacheOriginalImage])
            } else {
                 courseImageView.image = UIImage(named: "placeholderImage")
                blurredCourseImageView.image = UIImage(named: "placeholderImage")
            }
            courseTitleLabel.text = courseViewModel.title
            if let subTitle =  courseViewModel.subTitle {
                subdetailsLabel.text = subTitle
                subdetailsLabel.isHidden = false
            } else {
                subdetailsLabel.isHidden = true
            }
        }
    }
}
