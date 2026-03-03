//
//  TopSheetDelegate.swift
//  Practice Project
//
//  Created by Tharik Batcha on 03/03/26.
//

import UIKit

class TopSheetDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let animator = TopSheetAnimator()
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresenting = false
        return animator
    }
    
}

