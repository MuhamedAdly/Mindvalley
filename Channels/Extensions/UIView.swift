//
//  UIView.swift
//  Channels
//
//  Created by Mohamed Adly on 5/23/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundedCorner(radius: Float, borderWidth: Float, borderColor: UIColor) {
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
    func roundedCornerAsThumb() {
        roundedCorner(radius: 6, borderWidth: 0, borderColor: .clear)
    }
    func circular() {
        let radius = frame.width / 2.0
        roundedCorner(radius: Float(radius), borderWidth: 0, borderColor: .clear)
    }
    // swiftlint:disable function_parameter_count
    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float,
                   shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner,
                   fillColor: UIColor = .white) {
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
}
