//
//  CustomSheetAnimator.swift
//  Practice Project
//
//  Created by Tharik Batcha on 03/03/26.
//

import UIKit

class CustomSheetAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = true
    var fromTop = false   // 🔥 controls direction
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to) else { return }
            
            container.addSubview(toView)
            
            let height = container.frame.height * 0.5
            
            let finalFrame = CGRect(
                x: 0,
                y: fromTop ? 0 : container.frame.height - height,
                width: container.frame.width,
                height: height
            )
            
            let startFrame = fromTop
                ? finalFrame.offsetBy(dx: 0, dy: -height)
                : finalFrame.offsetBy(dx: 0, dy: height)
            
            toView.frame = startFrame
            
            UIView.animate(withDuration: 0.3, animations: {
                toView.frame = finalFrame
            }) { _ in
                transitionContext.completeTransition(true)
            }
            
        } else {
            
            guard let fromView = transitionContext.view(forKey: .from) else { return }
            
            let height = fromView.frame.height
            
            UIView.animate(withDuration: 0.3, animations: {
                fromView.frame.origin.y += self.fromTop ? -height : height
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
    }
}
