//
//  ViewController.swift
//  CryptoVault_189E
//
//  Created by utkarsh opalkar on Jan/12/21.
//

import UIKit
import PhoneNumberKit

class ViewController: UIViewController {

    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    
    var tapOut = UITapGestureRecognizer()
    let phoneNumberKit = PhoneNumberKit()
    
    var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapOut = UITapGestureRecognizer(target:self, action: #selector(dismissKeypad))
        self.view.addGestureRecognizer(tapOut)
    }

    @objc func dismissKeypad(){
        phoneNumberTextField.resignFirstResponder()
    }
    

    @IBAction func sendOtpTapped(_ sender: Any) {
        let phoneNumber = phoneNumberTextField.text?.filter { $0 >= "0" && $0 <= "9" } ?? ""
        if phoneNumber.count == 10 {
            
            do {
                let parsedPhoneNumber = try phoneNumberKit.parse(phoneNumberTextField.text ?? "")
                self.phoneNumber = phoneNumberKit.format(parsedPhoneNumber, toType: .national)
                self.errorLabel.text = "Verification code has been sent to \n\(self.phoneNumber)"
                self.errorLabel.textColor = .green
                dismissKeypad()
            }
            catch {
                errorLabel.text = "Please enter a valid phone number"
                errorLabel.textColor = .red
            }
            
        }
        else if phoneNumber.count == 0 {
            
            errorLabel.text = "Please enter your phone number first!"
            errorLabel.textColor = .red
            
        }
        else if phoneNumber.count != 10 {
            
            errorLabel.text = "Phone number must be 10 digits!"
            errorLabel.textColor = .red
            
        }
        
        errorLabel.isHidden = false
    }
}



