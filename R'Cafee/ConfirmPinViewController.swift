//
//  ConfirmPinViewController.swift
//  R'Cafee
//
//  Created by Kumari Mansi on 28/11/24.
//

import UIKit

class ConfirmPinViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var beanBlendLabel: UILabel!
    @IBOutlet var designAQuickLabel: UILabel!
    @IBOutlet var enter4DigitLabel: UILabel!
    @IBOutlet var enterPINTextField1: UITextField!
    @IBOutlet var enterPINTextField2: UITextField!
    @IBOutlet var enterPINTextField3: UITextField!
    @IBOutlet var enterPINTextField4: UITextField!
    
    @IBOutlet var confirm4DigitLabel: UILabel!
    @IBOutlet var confirmPINTextField1: UITextField!
    @IBOutlet var confirmPINTextField2: UITextField!
    @IBOutlet var confirmPINTextField3: UITextField!
    @IBOutlet var confirmPINTextField4: UITextField!
    
    @IBOutlet var setPINButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beanBlendLabel.font = UIFont(name: "Circe-Bold", size: 20)
        designAQuickLabel.font = UIFont(name: "Circe-Regular", size: 13)
        enter4DigitLabel.font = UIFont(name: "Circe-Bold", size: 16)
        confirm4DigitLabel.font = UIFont(name: "Circe-Bold", size: 16)
        setPINButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 14)
        setPINButton.isEnabled = false
        setPINButton.alpha = 0.5
        
       
        [enterPINTextField1, enterPINTextField2, enterPINTextField3, enterPINTextField4,
         confirmPINTextField1, confirmPINTextField2, confirmPINTextField3, confirmPINTextField4].forEach {
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.delegate = self
        }
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
   
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
       
        if let text = textField.text, text.count == 1 {
            switch textField {
            case enterPINTextField1: enterPINTextField2.becomeFirstResponder()
            case enterPINTextField2: enterPINTextField3.becomeFirstResponder()
            case enterPINTextField3: enterPINTextField4.becomeFirstResponder()
            case enterPINTextField4: confirmPINTextField1.becomeFirstResponder()
            case confirmPINTextField1: confirmPINTextField2.becomeFirstResponder()
            case confirmPINTextField2: confirmPINTextField3.becomeFirstResponder()
            case confirmPINTextField3: confirmPINTextField4.becomeFirstResponder()
            default: textField.resignFirstResponder()
            }
        }
        validatePIN()
    }
    
    private func validatePIN() {
        
        let enterPIN = (enterPINTextField1.text ?? "") +
                       (enterPINTextField2.text ?? "") +
                       (enterPINTextField3.text ?? "") +
                       (enterPINTextField4.text ?? "")
        
        let confirmPIN = (confirmPINTextField1.text ?? "") +
                         (confirmPINTextField2.text ?? "") +
                         (confirmPINTextField3.text ?? "") +
                         (confirmPINTextField4.text ?? "")
        
        
        let isValid = enterPIN.count == 4 && confirmPIN.count == 4 && enterPIN == confirmPIN
        
        
        setPINButton.isEnabled = isValid
        setPINButton.alpha = isValid ? 1.0 : 0.5
    }
    
    @IBAction func setPINButtonTapped(_ sender: UIButton) {
        
            if let storyboard = self.storyboard?.instantiateViewController(identifier: "NewViewController") as? NewViewController {
                        self.navigationController?.pushViewController(storyboard, animated: true)
                    }
                
        let enteredPIN = (enterPINTextField1.text ?? "") +
                         (enterPINTextField2.text ?? "") +
                         (enterPINTextField3.text ?? "") +
                         (enterPINTextField4.text ?? "")
        
        print("PIN set successfully: \(enteredPIN)")
        
    }
    
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count > 1 {
            return false
        }
        
        
        let allowedCharacterSet = CharacterSet.decimalDigits
        let characterSetFromString = CharacterSet(charactersIn: string)
        
       
        return allowedCharacterSet.isSuperset(of: characterSetFromString) && !string.contains(" ")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.text = ""
        
        
        switch textField {
        case enterPINTextField1: enterPINTextField2.becomeFirstResponder()
        case enterPINTextField2: enterPINTextField3.becomeFirstResponder()
        case enterPINTextField3: enterPINTextField4.becomeFirstResponder()
        case enterPINTextField4: confirmPINTextField1.becomeFirstResponder()
        case confirmPINTextField1: confirmPINTextField2.becomeFirstResponder()
        case confirmPINTextField2: confirmPINTextField3.becomeFirstResponder()
        case confirmPINTextField3: confirmPINTextField4.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
 }


