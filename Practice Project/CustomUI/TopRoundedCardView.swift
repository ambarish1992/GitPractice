//
//  TopRoundedCardView.swift
//  Practice Project
//
//  Created by Tharik Batcha on 27/02/26.
//

import UIKit

@IBDesignable
class TopRoundedCardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 20

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
    }
}
