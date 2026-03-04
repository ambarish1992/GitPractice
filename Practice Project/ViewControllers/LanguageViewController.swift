//
//  LanguageViewController.swift
//  Practice Project
//
//  Created by Tharik Batcha on 02/03/26.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var clickMeButton: UIButton!
    @IBOutlet weak var clickMeButton2: UIButton!
    
    var customSheetDelegate = CustomSheetDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickMeButton2.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    @IBAction func clickMeTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let vc = storyboard.instantiateViewController(
                withIdentifier: "LanguageBottomSheetViewController"
            ) as? LanguageBottomSheetViewController else { return }
            
            vc.viewModel = LanguageListViewModel()
            
            vc.modalPresentationStyle = .custom
            vc.isOppositeUser = false
            
            customSheetDelegate.fromTop = false
            vc.transitioningDelegate = customSheetDelegate
            
            vc.didSelectLanguage = { [weak self] language in
                self?.clickMeButton.setTitle(language.name, for: .normal)
            }
            
            present(vc, animated: true)
    }
    
    @IBAction func clickMeButton2Tapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let vc = storyboard.instantiateViewController(
                withIdentifier: "LanguageBottomSheetViewController"
            ) as? LanguageBottomSheetViewController else { return }
            
            vc.viewModel = LanguageListViewModel()
            
            vc.modalPresentationStyle = .custom
            vc.isOppositeUser = true
            
            customSheetDelegate.fromTop = true
            vc.transitioningDelegate = customSheetDelegate
            
            vc.didSelectLanguage = { [weak self] language in
                self?.clickMeButton2.setTitle(language.name, for: .normal)
            }
            
            present(vc, animated: true)
    }
    
}
