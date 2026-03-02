//
//  LanguageBottomSheetViewController.swift
//  Practice Project
//
//  Created by Tharik Batcha on 01/03/26.
//

import UIKit

class LanguageBottomSheetViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate{
    
    
    @IBOutlet weak var SearchTextfield: UITextField!
    @IBOutlet weak var SearchBarView: UIView!
    @IBOutlet weak var LanguageTableView: UITableView!
    @IBOutlet weak var dropDownView: UIView!
    
    private var searchBorder: GlassBorderLayer!
    private var tableBorder: GlassBorderLayer!
    
    var didSelectLanguage: ((Language) -> Void)?
    
    private var filteredLanguages: [Language] = []
    
    var languages: [Language] = [
        Language(name: "English (US)", nativeName: "English", countryCode: "US"),
        Language(name: "English (UK)", nativeName: "English", countryCode: "GB"),
        Language(name: "Hindi", nativeName: "हिन्दी", countryCode: "IN"),
        Language(name: "French", nativeName: "Français", countryCode: "FR"),
        Language(name: "Japanese", nativeName: "日本語", countryCode: "JP"),
        Language(name: "Chinese", nativeName: "中文", countryCode: "CN"),
        Language(name: "German", nativeName: "Deutsch", countryCode: "DE"),
        Language(name: "Spanish", nativeName: "Español", countryCode: "ES"),
        Language(name: "Portuguese", nativeName: "Português", countryCode: "PT"),
        Language(name: "Vietnamese", nativeName: "Tiếng Việt", countryCode: "VN"),
        Language(name: "Gujarati", nativeName: "ગુજરાતી", countryCode: "IN"),
        Language(name: "Tamil", nativeName: "தமிழ்", countryCode: "IN"),
        Language(name: "Marathi", nativeName: "मराठी", countryCode: "IN"),
        Language(name: "Telugu", nativeName: "తెలుగు", countryCode: "IN"),
        Language(name: "Malayalam", nativeName: "മലയാളം", countryCode: "IN"),
        Language(name: "Bengali", nativeName: "বাংলা", countryCode: "IN"),
        Language(name: "Kannada", nativeName: "ಕನ್ನಡ", countryCode: "IN"),
        Language(name: "Russian", nativeName: "Русский", countryCode: "RU"),
        Language(name: "Korean", nativeName: "한국어", countryCode: "KR"),
        Language(name: "Arabic", nativeName: "العربية", countryCode: "AE")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownView.layer.cornerRadius = 24
        dropDownView.layer.maskedCorners = [
            CACornerMask.layerMinXMinYCorner,
            CACornerMask.layerMaxXMinYCorner
        ]
        dropDownView.clipsToBounds = true
        
        
        LanguageTableView.layer.cornerRadius = 22
        LanguageTableView.clipsToBounds = true
        LanguageTableView.backgroundColor = .clear
        LanguageTableView.separatorColor = UIColor(
            red: 88/255,
            green: 88/255,
            blue: 88/255,
            alpha: 1.0
        )
        
        
        if let placeholder = self.SearchTextfield.placeholder {
            self.SearchTextfield.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: UIColor.white]
            )
        }
        
        filteredLanguages = languages
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addGradient()
        GlassBorderLayer.apply(to: SearchBarView , cornerRadius: 22 , attachToSuperview: false)
        GlassBorderLayer.apply(to: LanguageTableView, cornerRadius: 22, attachToSuperview: true)
    }
    
    private func addGradient() {
        
        dropDownView.layer.sublayers?
            .removeAll(where: { $0.name == "DropDownBackground" })
        
        let gradient = CAGradientLayer()
        gradient.name = "DropDownBackground"
        
        gradient.colors = [
            UIColor(red: 47/255, green: 47/255, blue: 47/255, alpha: 1).cgColor,
            UIColor.black.cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = dropDownView.bounds
        
        dropDownView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLanguages.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "LanguageCell",
            for: indexPath
        ) as? LanguageCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.configure(with: filteredLanguages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedLanguage = filteredLanguages[indexPath.row]
        
        didSelectLanguage?(selectedLanguage)
        
        dismiss(animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? LanguageCell else { return }
        
        let isLast =
        indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        cell.isLastCell = isLast
        cell.setNeedsLayout()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let text = textField.text?.lowercased() ?? ""
        
        if text.isEmpty {
            filteredLanguages = languages
        } else {
            filteredLanguages = languages.filter {
                $0.name.lowercased().contains(text) ||
                $0.nativeName.lowercased().contains(text)
            }
        }
        
        LanguageTableView.reloadData()
    }
    
}
