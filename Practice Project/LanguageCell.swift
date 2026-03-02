//
//  LanguageCell.swift
//  Practice Project
//
//  Created by Tharik Batcha on 01/03/26.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var flagLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nativeLabel: UILabel!
    
    var isLastCell: Bool = false
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isLastCell {
            separatorInset = UIEdgeInsets(
                top: 0,
                left: bounds.width,
                bottom: 0,
                right: 0
            )
        } else {
            separatorInset = .zero
        }
        
        preservesSuperviewLayoutMargins = false
        layoutMargins = .zero
    }
    
    func configure(with language: Language) {
           nameLabel.text = language.name
           nativeLabel.text = language.nativeName
           flagLabel.text = generateFlag(from: language.countryCode)
       }

       private func generateFlag(from countryCode: String) -> String {
           var flag = ""
           let base: UInt32 = 127397

           for scalar in countryCode.uppercased().unicodeScalars {
               if let unicode = UnicodeScalar(base + scalar.value) {
                   flag.unicodeScalars.append(unicode)
               }
           }

           return flag
       }

}
