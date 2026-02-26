//
//  ViewController.swift
//  Practice Project
//
//  Created by ambarish.shivakumar@Programming.com on 26/02/26.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var CardView: UIView!
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var FirstNameTextfield: UITextField!
    
    @IBOutlet weak var LastNameTextfield: UITextField!
    
    @IBOutlet weak var UserNameTextfield: UITextField!
    
    @IBOutlet weak var EmailTextfield: UITextField!
    
    @IBOutlet weak var PhoneTextfield: UITextField!
    
    @IBOutlet weak var ProfileScrollView: UIScrollView!
    
    @IBOutlet weak var ProfileSaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTextFields()
        setupTapGesture()
        registerForKeyboardNotifications()
        
        ProfileSaveButton.isEnabled = false
        updateSaveButtonUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        CardView.layer.cornerRadius = 20
        CardView.layer.maskedCorners = [
            .layerMinXMinYCorner,  // top-left
            .layerMaxXMinYCorner   // top-right
        ]
        CardView.clipsToBounds = true
        
        styleTextField(FirstNameTextfield)
        styleTextField(LastNameTextfield)
        styleTextField(UserNameTextfield)
        styleTextField(EmailTextfield)
        styleTextField(PhoneTextfield)
        
    }
    
    func styleTextField(_ textField: UITextField) {
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
    }
    func setupTextFields() {
        FirstNameTextfield.delegate = self
        LastNameTextfield.delegate = self
        UserNameTextfield.delegate = self
        EmailTextfield.delegate = self
        PhoneTextfield.delegate = self

        FirstNameTextfield.returnKeyType = .next
        LastNameTextfield.returnKeyType = .next
        UserNameTextfield.returnKeyType = .next
        EmailTextfield.returnKeyType = .next
        PhoneTextfield.returnKeyType = .done
        
        FirstNameTextfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        LastNameTextfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        UserNameTextfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        EmailTextfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        PhoneTextfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
        case FirstNameTextfield:
            LastNameTextfield.becomeFirstResponder()

        case LastNameTextfield:
            UserNameTextfield.becomeFirstResponder()

        case UserNameTextfield:
            EmailTextfield.becomeFirstResponder()

        case EmailTextfield:
            PhoneTextfield.becomeFirstResponder()

        case PhoneTextfield:
            textField.resignFirstResponder()

        default:
            textField.resignFirstResponder()
        }

        return true
    }
    
    func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func registerForKeyboardNotifications() {

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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        let rect = textField.convert(textField.bounds, to: ProfileScrollView)
        ProfileScrollView.scrollRectToVisible(rect, animated: true)
    }
    
    func validateFields() {

        let isFormValid =
            !(FirstNameTextfield.text?.isEmpty ?? true) &&
            !(LastNameTextfield.text?.isEmpty ?? true) &&
            !(UserNameTextfield.text?.isEmpty ?? true) &&
            !(EmailTextfield.text?.isEmpty ?? true) &&
            !(PhoneTextfield.text?.isEmpty ?? true)

        ProfileSaveButton.isEnabled = isFormValid
        updateSaveButtonUI()
    }
    
    func updateSaveButtonUI() {
        if ProfileSaveButton.isEnabled {
            ProfileSaveButton.backgroundColor = .systemBlue
            ProfileSaveButton.layer.cornerRadius = 12
            ProfileSaveButton.layer.masksToBounds = true
        } else {
            ProfileSaveButton.backgroundColor = .systemGray
            ProfileSaveButton.layer.cornerRadius = 12
            ProfileSaveButton.layer.masksToBounds = true
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height

        ProfileScrollView.contentInset.bottom = keyboardHeight
        ProfileScrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {

        ProfileScrollView.contentInset.bottom = 0
        ProfileScrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    @objc func textFieldDidChange() {
        validateFields()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {

        let alert = UIAlertController(
            title: "Success",
            message: "Your profile has been saved.",
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }
    
}

