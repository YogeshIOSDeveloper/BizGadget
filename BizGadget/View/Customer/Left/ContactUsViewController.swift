//
//  ContactUsViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 18/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var textName: BizGadgetTextField!
    @IBOutlet weak var textEmail: BizGadgetTextField!
    @IBOutlet weak var textCountry: BizGadgetTextField!
    @IBOutlet weak var textState: BizGadgetTextField!
    @IBOutlet weak var textCity: BizGadgetTextField!
    @IBOutlet weak var textPhone: BizGadgetTextField!
    @IBOutlet weak var textComment: UITextView!
    
    let Placeholder: String = "Business Address"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textComment.text = Placeholder
        textComment.textColor = UIColor.lightGray
        textComment.delegate = self //UITextViewDelegate
    }
  
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func btnSubmitClicked(_ sender: BizGadgetButton) {
        
        if validation() {
           print("Submit.......")
        }
    }
    
    
    func validation() -> Bool  {
        
        if (textName.text?.isEmpty)! {
            Alert.showAlert(message: "Enter UserName", viewController: self)
            return false
        }
        if (textEmail.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Email", viewController: self)
            return false
        }
        if (textCountry.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Country", viewController: self)
            return false
        }
        if (textState.text?.isEmpty)! {
            Alert.showAlert(message: "Enter State", viewController: self)
            return false
        }
        if (textCity.text?.isEmpty)! {
            Alert.showAlert(message: "Enter City", viewController: self)
            return false
        }
        if textPhone.text == "Business Address" {
            Alert.showAlert(message: "Enter Phone", viewController: self)
            return false
        }
        if textComment.text == Placeholder  {
            Alert.showAlert(message: "Enter Comment", viewController: self)
            return false
        }
        return true
    }

    
    
    
}

// UITextViewDelegate
extension ContactUsViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Placeholder
            textView.textColor = UIColor.lightGray
        }
    }
}


