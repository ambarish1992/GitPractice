//
//  ViewController.swift
//  Practice Project
//
//  Created by ambarish.shivakumar@Programming.com on 26/02/26.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var CardView: TopRoundedCardView!
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var FirstNameTextfield: StyledTextField!
    @IBOutlet weak var LastNameTextfield: StyledTextField!
    @IBOutlet weak var UserNameTextfield: StyledTextField!
    @IBOutlet weak var EmailTextfield: StyledTextField!
    @IBOutlet weak var PhoneTextfield: StyledTextField!
    @IBOutlet weak var ProfileScrollView: UIScrollView!
    @IBOutlet weak var ProfileSaveButton: PrimaryButton!
    
    private let viewModel = ProfileViewModel()
    private var keyboardManager: KeyboardManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        #if DEBUG
        debugPrint("viewDidLoad finished at", Date())
        #endif
        
        NotificationCenter.default.addObserver(
             self,
             selector: #selector(keyboardDidShow),
             name: UIResponder.keyboardDidShowNotification,
             object: nil
         )
        
        configureTextFields()
        keyboardManager = KeyboardManager(scrollView: ProfileScrollView)
        setupDismissKeyboardGesture()
        ProfileScrollView.keyboardDismissMode = .onDrag
        ProfileSaveButton.isEnabled = false
        updateSaveButton()
        addDoneButtonOnKeyboard()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let rect = textField.convert(textField.bounds, to: ProfileScrollView)
        ProfileScrollView.scrollRectToVisible(rect, animated: true)
        #if DEBUG
        debugPrint("textfield tapped at", Date())
        #endif
    }
    
    private func configureTextFields() {

           let fields = [
               FirstNameTextfield,
               LastNameTextfield,
               UserNameTextfield,
               EmailTextfield,
               PhoneTextfield
           ]

           fields.enumerated().forEach { index, field in
               field?.returnKeyType = index == fields.count - 1 ? .done : .next
               field?.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
           }
       }

       @objc private func textDidChange() {

           viewModel.firstName = FirstNameTextfield.text ?? ""
           viewModel.lastName = LastNameTextfield.text ?? ""
           viewModel.userName = UserNameTextfield.text ?? ""
           viewModel.email = EmailTextfield.text ?? ""
           viewModel.phone = PhoneTextfield.text ?? ""

           updateSaveButton()
       }

       private func updateSaveButton() {
           let valid = viewModel.isFormValid
           ProfileSaveButton.isEnabled = valid
           ProfileSaveButton.updateAppearance(isEnabled: valid)
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
           default:
               textField.resignFirstResponder()
           }

           return true
       }
    
    private func setupDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func addDoneButtonOnKeyboard() {

        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(dismissKeyboard)
        )

        toolbar.items = [flexSpace, doneButton]

        let fields = [
            FirstNameTextfield,
            LastNameTextfield,
            UserNameTextfield,
            EmailTextfield,
            PhoneTextfield
        ]

        fields.forEach {
            $0?.inputAccessoryView = toolbar
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as? RatingViewController
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        #if DEBUG
        debugPrint("Keyboard fully visible at", Date())
        #endif
    }
    
}

