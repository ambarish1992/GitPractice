//
//  GlassBorderLayer.swift
//  Practice Project
//
//  Created by Tharik Batcha on 02/03/26.
//

import UIKit

final class GlassBorderLayer {

    static func apply(to view: UIView,
                      cornerRadius: CGFloat,
                      attachToSuperview: Bool = false) {

        let hostView = attachToSuperview ? view.superview : view

        guard let container = hostView else { return }

        let layerName = "GlassBorderLayer_\(ObjectIdentifier(view).hashValue)"

        let gradientLayer: CAGradientLayer

        if let existing = container.layer.sublayers?
            .first(where: { $0.name == layerName }) as? CAGradientLayer {
            gradientLayer = existing
        } else {
            gradientLayer = CAGradientLayer()
            gradientLayer.name = layerName
            container.layer.addSublayer(gradientLayer)
        }

        let frame: CGRect

        if attachToSuperview {
            frame = container.convert(view.frame, from: view.superview)
        } else {
            frame = view.bounds
        }

        gradientLayer.frame = frame

        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0.9).cgColor,
            UIColor.white.withAlphaComponent(0.6).cgColor,
            UIColor.white.withAlphaComponent(0.1).cgColor,
            UIColor.white.withAlphaComponent(0.1).cgColor,
            UIColor.white.withAlphaComponent(0.7).cgColor
        ]

        gradientLayer.locations = [0.0, 0.15, 0.35, 0.65, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 1)

        let mask = CAShapeLayer()
        mask.frame = gradientLayer.bounds
        mask.path = UIBezierPath(
            roundedRect: gradientLayer.bounds.insetBy(dx: 0.6, dy: 0.6),
            cornerRadius: cornerRadius
        ).cgPath

        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.black.cgColor
        mask.lineWidth = 1.2

        gradientLayer.mask = mask
    }
}
