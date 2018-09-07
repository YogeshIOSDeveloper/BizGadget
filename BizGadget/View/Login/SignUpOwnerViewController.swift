//
//  SignUpViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class SignUpOwnerViewController: UIViewController {

    @IBOutlet weak var textUserName: BizGadgetTextField!
    @IBOutlet weak var textEmail: BizGadgetTextField!
    @IBOutlet weak var textPassword: BizGadgetTextField!
    @IBOutlet weak var textBussinessName: BizGadgetTextField!
    @IBOutlet weak var textFirstName: BizGadgetTextField!
    @IBOutlet weak var textLastName: BizGadgetTextField!
    @IBOutlet weak var textAddress: UITextView!
    @IBOutlet weak var textBussinessNumber: BizGadgetTextField!
    @IBOutlet weak var textMobileNumber: BizGadgetTextField!
    @IBOutlet weak var imageProfile: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textAddress.text = "Business Address"
        textAddress.textColor = UIColor.lightGray
        textAddress.delegate = self //UITextViewDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    @IBAction func btnSignInClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRegister(_ sender: BizGadgetButton) {
        
        if signUpValidation() {
            print("Sign up .....")
            
            Webservices.shared.SignUpBusiness(user_name: self.textUserName.text ?? " ",
                                              email: self.textEmail.text ?? " ",
                                              password: self.textPassword.text ?? " ",
                                              mobile: self.textEmail.text ?? " ",
                                              type: USER_OWNER,
                                              business_name: self.textBussinessName.text ?? " ",
                                              business_owner_first_name: self.textFirstName.text ?? " ",
                                              business_owner_last_name: self.textLastName.text ?? " ",
                                              business_address: self.textAddress.text ?? " ",
                                              business_mobile: self.textMobileNumber.text ?? " ",
                                              latitude: "",
                                              longitude: "",
                                              accuracy: "15",
                                              tags: ["chinese", "indian", "veg"],
                                              image0: imageProfile.image!,
                                              success: {
                                                success in
            }, failure: {
                error in
            })
        }
    }
    
    func signUpValidation() -> Bool  {
        if (textUserName.text?.isEmpty)! {
            Alert.showAlert(message: "Enter UserName", viewController: self)
            return false
        }
        if (textPassword.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Password", viewController: self)
            return false
        }
        if (textBussinessName.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Business Name", viewController: self)
            return false
        }
        if (textFirstName.text?.isEmpty)! {
            Alert.showAlert(message: "Enter First Name", viewController: self)
            return false
        }
        if (textLastName.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Last Name", viewController: self)
            return false
        }
        if textBussinessNumber.text == "Business Address" {
            Alert.showAlert(message: "Enter Business Address", viewController: self)
            return false
        }
        if (textBussinessNumber.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Business Number", viewController: self)
            return false
        }
        if (textMobileNumber.text?.isEmpty)!{
            Alert.showAlert(message: "Enter Mobile Number", viewController: self)
            return false
        }
        return true
    }
   
    
}


// UITextViewDelegate
extension SignUpOwnerViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Business Address"
            textView.textColor = UIColor.lightGray
        }
    }
}
