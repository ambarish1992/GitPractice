//
//  LanguageViewController.swift
//  Practice Project
//
//  Created by Tharik Batcha on 02/03/26.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var clickMeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickMeTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         guard let vc = storyboard.instantiateViewController(
             withIdentifier: "LanguageBottomSheetViewController"
         ) as? LanguageBottomSheetViewController else { return }
         
         vc.modalPresentationStyle = .pageSheet
        
         if let sheet = vc.sheetPresentationController {
             sheet.detents = [.medium(), .large()]
             sheet.selectedDetentIdentifier = .medium
             sheet.prefersGrabberVisible = false
             
         }
         
         vc.didSelectLanguage = { [weak self] language in
             self?.clickMeButton.setTitle(language.name, for: .normal)
         }
         
         present(vc, animated: true)
        
    }
    

}
