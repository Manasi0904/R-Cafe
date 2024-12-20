//
//  PersonalViewController.swift
//  R'Cafee
//
//  Created by Kumari Mansi on 26/11/24.
//

import UIKit

class PersonalViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var SpillLabel: UILabel!
    @IBOutlet weak var shareYourDetailsLabel: UILabel!
    
    @IBOutlet weak var nameUIView: UIView!
    @IBOutlet weak var dateOfBirthUIView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userDateOfBirthTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    @IBOutlet weak var brownImage: UIImageView!
    
    @IBOutlet weak var gotReferralLabel: UILabel!
    @IBOutlet weak var enterReferralLabel: UILabel!
    
    @IBOutlet weak var entercodeButton: UIButton!
    
    @IBOutlet weak var continue3Button: UIButton!
    
    @IBOutlet weak var main3View: UIView!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDateOfBirthTextField.addTarget(self, action: #selector(pickDateofBirth), for: .touchDown)
        configureTextFieldValidation()
        
        configureUI()
    }
    
    private func configureUI() {
        main3View.layer.cornerRadius = 30
        main3View.layer.masksToBounds = true
        main3View.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        SpillLabel.font = UIFont(name: "Circe-Bold", size: 20)
        shareYourDetailsLabel.font = UIFont(name: "Circe-Regular", size: 13)
        nameUIView.layer.borderWidth = 0.5
        nameUIView.layer.borderColor = UIColor.lightGray.cgColor
        nameUIView.layer.cornerRadius = 8
        
        nameTextField.font = UIFont(name: "Circe-Regular", size: 12)
        userNameTextField.font = UIFont(name: "Circe-Regular", size: 15)
        
        dateOfBirthUIView.layer.borderWidth = 0.5
        dateOfBirthUIView.layer.borderColor = UIColor.lightGray.cgColor
        dateOfBirthUIView.layer.cornerRadius = 8
        
        dateOfBirthTextField.adjustsFontSizeToFitWidth = true
        dateOfBirthTextField.font = UIFont(name: "Circe-Regular", size: 12)
        userDateOfBirthTextField.font = UIFont(name: "Circe-Regular", size: 15)
        
        brownImage.layer.cornerRadius = 20
        gotReferralLabel.font = UIFont(name: "Circe-Bold", size: 17)
        enterReferralLabel.font = UIFont(name: "Circe-Light", size: 10)
        
        entercodeButton.layer.cornerRadius = 5
        entercodeButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 12)
        
        continue3Button.titleLabel?.font = UIFont(name: "Circe-Regular", size: 14)
        continue3Button.layer.cornerRadius = 10
        continue3Button.isEnabled = false
        continue3Button.alpha = 0.5
        
        
        
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func pickDateofBirth() {
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
        toolbar.items = [doneBtn]
        userDateOfBirthTextField.inputView = datePicker
        userDateOfBirthTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonClicked() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        // formatter.dateStyle = .medium
        userDateOfBirthTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        validateInputs()
    }
    
    private func configureTextFieldValidation() {
        
        nameTextField.addTarget(self, action: #selector(validateInputs), for: .editingChanged)
        userDateOfBirthTextField.addTarget(self, action: #selector(validateInputs), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    @objc private func validateInputs() {
        
        let isNameValid = !(userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false) && userNameTextField.text!.count <= 100
        
        
        let isDateOfBirthValid = !(userDateOfBirthTextField.text?.isEmpty ?? true)
        
        
        updateContinueButtonState(isNameValid: isNameValid, isDateOfBirthValid: isDateOfBirthValid)
        
        
    }
    
    
    private func updateContinueButtonState(isNameValid: Bool, isDateOfBirthValid: Bool) {
        if isNameValid && isDateOfBirthValid {
            continue3Button.isEnabled = true
            
            continue3Button.alpha = 1.0
        } else {
            continue3Button.isEnabled = false
            continue3Button.alpha = 0.5
        }
        
    }
    
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        if continue3Button.isEnabled {
            if let confirmPinVC = storyboard?.instantiateViewController(withIdentifier: "ConfirmPinViewController") {
                self.navigationController?.pushViewController(confirmPinVC, animated: true)
            }
        }
    }
    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == nameTextField {
                let currentText = textField.text ?? ""
                let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
                return updatedText.count <= 50
            }
            return true
        }
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == userNameTextField {
//            let currentText = textField.text ?? ""
//            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
//            
//            // Capitalize only the first character of the first word
//            if updatedText.count == 1 {
//                textField.text = updatedText.capitalized
//                return false
//            }
//        }
//        return true
//    }
//    
//}
