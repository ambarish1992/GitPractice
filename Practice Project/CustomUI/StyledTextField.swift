//
//  StyledTextField.swift
//  Practice Project
//
//  Created by Tharik Batcha on 27/02/26.
//

import UIKit

@IBDesignable
class StyledTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 12
    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = .lightGray

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
        backgroundColor = .white
    }
}
