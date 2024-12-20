//
//  OTPViewController.swift
//  R'Cafee
//
//  Created by Kumari Mansi on 25/11/24.
//

import UIKit

class OTPViewController: UIViewController, UITextFieldDelegate, OTPFieldDelegate {
    
    var count = 30
    var timer: Timer?
    var phoneNumber: String?
    var isOTPEntered = false
    var recievedata = String()
    
    @IBOutlet weak var VerifyDetailsLabel: UILabel!
    @IBOutlet weak var OTPSentLabel: UILabel!
    @IBOutlet weak var PleaseEnterLabel: UILabel!
    @IBOutlet weak var EnterOTPLabel: UILabel!
    
    @IBOutlet weak var OTPwasSentLabel: UILabel!
    @IBOutlet weak var txtOTP1: OTPTextField!
    @IBOutlet weak var txtOTP2: OTPTextField!
    @IBOutlet weak var txtOTP3: OTPTextField!
    @IBOutlet weak var txtOTP4: OTPTextField!
    @IBOutlet weak var txtOTP5: OTPTextField!
    @IBOutlet weak var txtOTP6: OTPTextField!
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var DidnotReceiveLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var continue2Button: UIButton!
    
    @IBOutlet weak var main2View: UIView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        OTPSentLabel.text = recievedata
            
            VerifyDetailsLabel.font = UIFont(name:"Circe-Bold", size: 20)
            OTPSentLabel.font = UIFont(name:"Circe-Regular", size: 14)
            OTPwasSentLabel.font = UIFont(name:"Circe-Regular", size: 14)
            PleaseEnterLabel.font = UIFont(name:"Circe-Regular", size: 14)
            EnterOTPLabel.font = UIFont(name:"Circe-Regular", size: 16)
            DidnotReceiveLabel.font = UIFont(name:"Circe-Regular", size: 12)
            countDownLabel.font = UIFont(name: "Circe-Regular", size: 12)
            resendButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
            continue2Button.titleLabel?.font = UIFont(name: "Circe-Regular", size: 14)
            continue2Button.layer.cornerRadius = 10
        
        main2View.layer.cornerRadius = 30
        main2View.layer.masksToBounds = true
        main2View.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let resendText = "Resend"
        let attributedString = NSMutableAttributedString(string: resendText)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: resendText.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.saddleBrown, range: NSRange(location: 0, length: resendText.count))
        resendButton.setAttributedTitle(attributedString, for: .normal)
           
            
           
        [txtOTP1, txtOTP2, txtOTP3, txtOTP4, txtOTP5, txtOTP6].forEach { otpTextField in
                otpTextField?.delegate = self
                otpTextField?.backDelegate = self
            }
            
            startTimer()
            disableContinueButton()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            timer?.invalidate()
            timer = nil
        }
    
    func updateTimer() {
           if count > 0 {
               let minutes = count / 60
               let seconds = count % 60
               countDownLabel.text = String(format: "%02d:%02d", minutes, seconds)
               count -= 1
           } else {
               countDownLabel.text = "00:00"
               resendButton.isEnabled = true
               resendButton.alpha = 1.0
               
           }
       }
       
       func startTimer() {
           resendButton.isEnabled = false
           resendButton.alpha = 0.5
           count = 30
           countDownLabel.text = "00:30"
           
           timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
               self?.updateTimer()
           }
       }
    

    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func resendClicked(_ sender: Any) {
        
        [txtOTP1, txtOTP2, txtOTP3, txtOTP4, txtOTP5, txtOTP6].forEach { otpTextField in
                   otpTextField?.text = ""
               }
               disableContinueButton()
               startTimer()
           }
    
    
    @IBAction func clicked2Button(_ sender: Any) {
        if let storyboard = self.storyboard?.instantiateViewController(identifier: "PersonalViewController") as? PersonalViewController {
                    self.navigationController?.pushViewController(storyboard, animated: true)
                }
            }
            
           
            func disableContinueButton() {
                continue2Button.isEnabled = false
                continue2Button.alpha = 0.5
            }

          
            func enableContinueButton() {
                continue2Button.isEnabled = true
                continue2Button.alpha = 1.0
            }
            
           
            func checkForOTP() {
                let otp = [txtOTP1, txtOTP2, txtOTP3, txtOTP4, txtOTP5, txtOTP6]
                isOTPEntered = otp.allSatisfy { otpTextField in otpTextField?.text?.count == 1 }
                
                if isOTPEntered {
                    enableContinueButton()
                } else {
                    disableContinueButton()
                }
            }
            
            
            func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                guard string.count <= 1, let currentText = textField.text else { return false }

                if string.isEmpty {
                    textField.text = ""
                    switch textField {
                    case txtOTP2: txtOTP1.becomeFirstResponder()
                    case txtOTP3: txtOTP2.becomeFirstResponder()
                    case txtOTP4: txtOTP3.becomeFirstResponder()
                    case txtOTP5: txtOTP4.becomeFirstResponder()
                    case txtOTP6: txtOTP5.becomeFirstResponder()
                    default: break
                    }
                } else if let _ = Int(string) {
                    textField.text = string
                    switch textField {
                    case txtOTP1: txtOTP2.becomeFirstResponder()
                    case txtOTP2: txtOTP3.becomeFirstResponder()
                    case txtOTP3: txtOTP4.becomeFirstResponder()
                    case txtOTP4: txtOTP5.becomeFirstResponder()
                    case txtOTP5: txtOTP6.becomeFirstResponder()
                    default: textField.resignFirstResponder()
                    }
                }
                
                checkForOTP()
                
                return false
            }
            
            func backwardDetected(textField: OTPTextField) {
                switch textField {
                case txtOTP1: print("txtOTP1 --> no change")
                case txtOTP2: txtOTP1.becomeFirstResponder()
                case txtOTP3: txtOTP2.becomeFirstResponder()
                case txtOTP4: txtOTP3.becomeFirstResponder()
                case txtOTP5: txtOTP4.becomeFirstResponder()
                case txtOTP6: txtOTP5.becomeFirstResponder()
                default: print("at default")
                }
            }
        }

        protocol OTPFieldDelegate: AnyObject {
            func backwardDetected(textField: OTPTextField)
        }

        class OTPTextField: UITextField {
            weak var backDelegate: OTPFieldDelegate?
            
            override func deleteBackward() {
                super.deleteBackward()
                self.backDelegate?.backwardDetected(textField: self)
            }
}


