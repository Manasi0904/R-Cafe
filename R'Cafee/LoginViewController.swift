//
//  LoginViewController.swift
//  R'Cafee
//
//  Created by Kumari Mansi on 22/11/24.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

var activeTextField: UITextField!
var isChecked = false
    
    
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet var iAgreeToLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mobileView: UIView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    resetForm()
    skipButton.titleLabel?.font = UIFont(name: "Circe-Bold", size: 12)
    myLabel.font = UIFont(name:"Circe-Regular", size: 22)      //WELCOME
    loginLabel.font = UIFont(name:"Circe-Regular", size: 14)
    continueButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 14)
    phoneTF.font = UIFont(name:"Circe-Regular", size: 13)
    continueButton.layer.cornerRadius = 10
    checkBoxButton.layer.cornerRadius = 2
   
        mainView.layer.cornerRadius = 30
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mobileView.layer.cornerRadius = 10
        privacyPolicyLabel.font = UIFont(name: "Inter-Regular", size: 12)
        iAgreeToLabel.font = UIFont(name: "Inter-Regular", size: 12)
        
        
        let privacyText = "Privacy Policy, Terms and Conditions"
        let attributedString = NSMutableAttributedString(string: privacyText)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: privacyText.count))
        attributedString.addAttribute(.underlineColor, value: UIColor.black, range: NSRange(location: 0, length: privacyText.count))
        privacyPolicyLabel.attributedText = attributedString
      
        
    phoneTF.delegate = self
    phoneTF.keyboardType = .numberPad
    phoneTF.addTarget(self, action: #selector(phoneChanged), for: .editingChanged)
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        
        
    
    let center: NotificationCenter = NotificationCenter.default
                center.addObserver(self, selector: #selector(keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                center.addObserver(self, selector: #selector(keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            }
            
            @objc func keyboardShown(notification: Notification) {
                bottomHeight.constant = -250
                view.layoutIfNeeded()

            }
            
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
            @objc func keyboardHidden(notification: Notification) {
                bottomHeight.constant = 0
                view.layoutIfNeeded()

            }
            
    func resetForm() {
    continueButton.isEnabled = false
    updateContinueButtonOpacity()
    phoneTF.text = ""
    isChecked = false
    checkBoxButton.setTitle("", for: .normal)
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        DispatchQueue.main.async {
        self.isChecked.toggle()
        self.checkBoxButton.setTitle(self.isChecked ? "✓" : "", for: .normal)
        self.checkForValidForm()
        }
    }
    
    
    @IBAction func skip(_ sender: Any) {
        
        let storyboard = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
    @IBAction func continueAction(_ sender: Any) {
        var datatosend = "+" + phoneTF.text!
      
        let storyboard = self.storyboard?.instantiateViewController(identifier: "OTPViewController") as! OTPViewController
        storyboard.recievedata = datatosend
        self.navigationController?.pushViewController(storyboard, animated: true)
        
        resetForm()
    }
        
    
    
    @IBAction func phoneChanged(_ sender: Any) {
        if let phoneNumber = phoneTF.text {
            if phoneNumber.count == 10 {
                phoneTF.resignFirstResponder()
                checkForValidForm()
            } else if
                phoneNumber.count > 10 {
                phoneTF.text = String(phoneNumber.prefix(10))
            }
        }
        checkForValidForm()
    }
    
    func checkForValidForm() {
    if let phoneNumber = phoneTF.text, phoneNumber.count == 10, isChecked {
    continueButton.isEnabled = true
    } else {
    continueButton.isEnabled = false
   }
        updateContinueButtonOpacity()
    }
    func updateContinueButtonOpacity() {
            continueButton.alpha = continueButton.isEnabled ? 1.0 : 0.5
        }
    }
    
extension LoginViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
