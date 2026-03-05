//
//  RatingViewController.swift
//  Practice Project
//
//  Created by Tharik Batcha on 27/02/26.
//

import UIKit

class RatingViewController: UIViewController {

    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    @IBOutlet weak var SubmitButton: UIButton!
    
    var currentRating = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateRating(selectedRating: Int) {
        currentRating = selectedRating
        
        let buttons = [star1Button,
                       star2Button,
                       star3Button,
                       star4Button,
                       star5Button]
        
        for (index, button) in buttons.enumerated() {
            button?.setImage(
                UIImage(named: index < currentRating ? "StarFill" : "Star"),
                for: .normal
            )
        }
        updateSubmitButtonTitle()
    }
    
    func updateSubmitButtonTitle() {
        
        let title: String
        
        switch currentRating {
        case 1:
            title = "Very Bad"
        case 2:
            title = "Not Bad"
        case 3:
            title = "Good"
        case 4:
            title = "Very Good"
        case 5:
            title = "Excellent"
        default:
            title = "Submit"
        }
        
        SubmitButton.setTitle(title, for: .normal)
    }
    
    @IBAction func ratingTapped(_ sender: UIButton) {
        #if DEBUG
        debugPrint(sender.tag)
        #endif
        updateRating(selectedRating: sender.tag)
    }

    @IBAction func SubmitButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(
            title: "Thankyou",
            message: "Your ratings has been saved.",
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
        
    }
}
