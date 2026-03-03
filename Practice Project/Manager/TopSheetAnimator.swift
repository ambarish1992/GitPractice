//
//  TopSheetAnimator.swift
//  Practice Project
//
//  Created by Tharik Batcha on 03/03/26.
//

import UIKit

class TopSheetAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = true
    var sheetHeight: CGFloat = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to) else { return }
            
            container.addSubview(toView)
            
            sheetHeight = container.frame.height * 0.5
            
            let finalFrame = CGRect(
                x: 0,
                y: 0,
                width: container.frame.width,
                height: sheetHeight
            )
            
            toView.frame = finalFrame.offsetBy(dx: 0, dy: -sheetHeight)
            
            UIView.animate(withDuration: 0.3, animations: {
                toView.frame = finalFrame
            }) { _ in
                transitionContext.completeTransition(true)
            }
            
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else { return }
            
            UIView.animate(withDuration: 0.3, animations: {
                fromView.frame.origin.y = -fromView.frame.height
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
    }
}
