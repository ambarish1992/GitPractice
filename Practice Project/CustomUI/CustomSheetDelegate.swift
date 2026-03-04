//
//  CustomSheetDelegate.swift
//  Practice Project
//
//  Created by Tharik Batcha on 03/03/26.
//

import UIKit


class CustomSheetDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let animator = CustomSheetAnimator()
    
    var fromTop = false
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        animator.isPresenting = true
        animator.fromTop = fromTop
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        animator.isPresenting = false
        animator.fromTop = fromTop
        return animator
    }
}
