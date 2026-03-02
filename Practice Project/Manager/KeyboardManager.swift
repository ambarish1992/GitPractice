//
//  KeyboardManager.swift
//  Practice Project
//
//  Created by Tharik Batcha on 27/02/26.
//

import UIKit

class KeyboardManager {
    
    private weak var scrollView: UIScrollView?
    
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        registerForNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let scrollView = scrollView else { return }
        
        let height = keyboardFrame.height
        
        scrollView.contentInset.bottom = height
        scrollView.verticalScrollIndicatorInsets.bottom = height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView?.contentInset.bottom = 0
        scrollView?.verticalScrollIndicatorInsets.bottom = 0
    }
}
