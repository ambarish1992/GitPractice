//
//  PrimaryButton.swift
//  Practice Project
//
//  Created by Tharik Batcha on 27/02/26.
//

import UIKit


@IBDesignable
class PrimaryButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 12

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }

    func updateAppearance(isEnabled: Bool) {
        backgroundColor = isEnabled ? .systemBlue : .systemGray
    }
}
