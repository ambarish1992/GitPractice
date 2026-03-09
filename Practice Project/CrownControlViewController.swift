//
//  CrownControlViewController.swift
//  Practice Project
//
//  Created by Tharik anver  on 06/03/26.
//

import UIKit
import Lottie

class CrownControlViewController: UIViewController {


    @IBOutlet weak var rotatingWheelView: UIView!
    @IBOutlet weak var selectionHighlightView: UIView!
    @IBOutlet weak var lottieView: UIView!
    
       private var lastAngle: CGFloat = 0
       private var currentRotation: CGFloat = 0

       private var iconViews: [UIImageView] = []
       private let iconCount = 9

       private var radius: CGFloat = 0
       private var centerPoint: CGPoint = .zero
       var arcLayer: CAShapeLayer?
    
       var animationView: LottieAnimationView?
    

       override func viewDidLoad() {
           super.viewDidLoad()

           let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
           rotatingWheelView.addGestureRecognizer(panGesture)

           rotatingWheelView.isUserInteractionEnabled = true
           
           setupAnimation()
           
       }

       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()

           rotatingWheelView.layer.cornerRadius = rotatingWheelView.bounds.width / 2
           radius = rotatingWheelView.bounds.width / 2 - 50
          
           
           centerPoint = CGPoint(
               x: rotatingWheelView.bounds.midX,
               y: rotatingWheelView.bounds.midY
           )

           if iconViews.isEmpty {
               setupIcons()
           }

           applyHighlightMask()
           
           addBottomArc()
           addTopGradientCover()
       }
    
    // MARK: Setup Animation
    
    func setupAnimation() {

           animationView = LottieAnimationView(name: "Case_03")

           guard let animationView = animationView else { return }

           animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        self.animationView?.play(
                    fromProgress: 1.0,
                    toProgress: 0.0,
                    loopMode: .playOnce
                )
        animationView.animationSpeed = 0.6
        self.tiltCrownUp()
        

        lottieView.addSubview(animationView)

           NSLayoutConstraint.activate([
               animationView.topAnchor.constraint(equalTo: lottieView.topAnchor),
               animationView.bottomAnchor.constraint(equalTo: lottieView.bottomAnchor),
               animationView.leadingAnchor.constraint(equalTo: lottieView.leadingAnchor),
               animationView.trailingAnchor.constraint(equalTo: lottieView.trailingAnchor)
           ])
       }
       // MARK: Highlight Shape

       private func applyHighlightMask() {

           let w = selectionHighlightView.bounds.width
           let h = selectionHighlightView.bounds.height

           let topWidth: CGFloat = w * 0.4
           let bottomWidth: CGFloat = w * 0.8

           let centerX = w / 2

           let path = UIBezierPath()

           path.move(to: CGPoint(x: centerX - topWidth/2, y: 0))
           path.addLine(to: CGPoint(x: centerX + topWidth/2, y: 0))
           path.addLine(to: CGPoint(x: centerX + bottomWidth/2, y: h))
           path.addLine(to: CGPoint(x: centerX - bottomWidth/2, y: h))
           path.close()

           let mask = CAShapeLayer()
           mask.path = path.cgPath

           selectionHighlightView.layer.mask = mask
       }

       // MARK: Bottom Arc

    func addBottomArc() {

        arcLayer?.removeFromSuperlayer()

        let wheelRadius = rotatingWheelView.bounds.width / 2

        // move arc closer to the edge
        let arcRadius = wheelRadius - 6

        let center = CGPoint(
            x: rotatingWheelView.bounds.midX,
            y: rotatingWheelView.bounds.midY
        )

        let path = UIBezierPath(
            arcCenter: center,
            radius: arcRadius,
            startAngle: CGFloat.pi * 0.12,
            endAngle: CGFloat.pi * 0.88,
            clockwise: true
        )

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.white.withAlphaComponent(0.35).cgColor
        layer.lineWidth = 4   // thicker arc
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round

        rotatingWheelView.layer.insertSublayer(layer, at: 0)

        arcLayer = layer
    }

       // MARK: Setup Icons

    func setupIcons() {

        let icons = [
            UIImage(systemName: "waveform"),
            UIImage(systemName: "slider.horizontal.3"),
            UIImage(systemName: "square.stack.3d.up")
        ]

        for i in 0..<iconCount {

            let imageView = UIImageView(image: icons[i % icons.count])
            imageView.tintColor = .white
            imageView.frame.size = CGSize(width: 40, height: 40)
            imageView.contentMode = .scaleAspectFit

            imageView.isUserInteractionEnabled = true
            imageView.tag = i

            let tap = UITapGestureRecognizer(target: self, action: #selector(iconTapped(_:)))
            imageView.addGestureRecognizer(tap)

            rotatingWheelView.addSubview(imageView)
            iconViews.append(imageView)
        }

        updateIconPositions()
    }
    
    @objc func iconTapped(_ gesture: UITapGestureRecognizer) {

        guard let tappedIcon = gesture.view else { return }

        let index = tappedIcon.tag

        rotateWheelToIndex(index)
    }
    
    func rotateWheelToIndex(_ index: Int) {

        let stepAngle = (2 * CGFloat.pi) / CGFloat(iconCount)

        // same offset you use in updateIconPositions
        let startOffset = CGFloat.pi / 2

        let targetAngle = -(CGFloat(index) * stepAngle)

        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       options: .curveEaseOut) {

            self.currentRotation = targetAngle
            self.updateIconPositions()
        }
    }
    
    // MARK: Top Mask
    
    func addTopGradientCover() {

        let gradient = CAGradientLayer()
        gradient.frame = rotatingWheelView.bounds

        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.black.cgColor,
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]

        gradient.locations = [0.0, 0.35, 0.70, 1.0]

        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)

        rotatingWheelView.layer.addSublayer(gradient)

        rotatingWheelView.bringSubviewToFront(lottieView)
    }
    
       // MARK: Icon Position Math
    
    func updateIconPositions() {

        let stepAngle = (2 * CGFloat.pi) / CGFloat(iconCount)

        let startOffset = CGFloat.pi / 2
        let highlightAngle = CGFloat.pi / 2

        for (index, icon) in iconViews.enumerated() {

            let angle = startOffset + currentRotation + CGFloat(index) * stepAngle

            let x = centerPoint.x + radius * cos(angle)
            let y = centerPoint.y + radius * sin(angle)

            icon.center = CGPoint(x: x, y: y)

            // keep icons upright
            icon.transform = CGAffineTransform(rotationAngle: -angle)

            // MARK: highlight scaling

            let normalizedAngle = atan2(sin(angle), cos(angle))
            let diff = abs(normalizedAngle - highlightAngle)

            let scale: CGFloat

            if diff < stepAngle * 0.35 {
                scale = 1.25     // icon in highlight
            } else if diff < stepAngle * 0.7 {
                scale = 1.10     // neighbors
            } else {
                scale = 1.0
            }

            UIView.animate(withDuration: 0.15) {
                icon.transform = icon.transform.scaledBy(x: scale, y: scale)
            }
        }
    }

       // MARK: Rotation Gesture

       @objc private func handleRotation(_ gesture: UIPanGestureRecognizer) {

           let location = gesture.location(in: rotatingWheelView)

           let angle = atan2(
               location.y - centerPoint.y,
               location.x - centerPoint.x
           )

           switch gesture.state {

           case .began:
               lastAngle = angle

           case .changed:

               let difference = angle - lastAngle

               currentRotation += difference

               updateIconPositions()

               lastAngle = angle

           case .ended:

               snapToNearestIcon()

           default:
               break
           }
       }

       // MARK: Snap

    func snapToNearestIcon() {

        let stepAngle = (2 * CGFloat.pi) / CGFloat(iconCount)

        let snappedIndex = round(currentRotation / stepAngle)

        let snappedAngle = snappedIndex * stepAngle

        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseOut) {

            self.currentRotation = snappedAngle
            self.updateIconPositions()
        }
    }
    
    func tiltCrownUp() {

        guard let animationView else { return }

        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / 500   // perspective

        transform = CATransform3DRotate(
            transform,
            -20 * .pi / 180,
            1,
            0,
            0
        )

        UIView.animate(withDuration: 0.4) {
            animationView.layer.transform = transform
        }
    }
    
   }
