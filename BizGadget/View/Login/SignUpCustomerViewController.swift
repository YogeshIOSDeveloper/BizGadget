//
//  SignUpCustomerViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class SignUpCustomerViewController: UIViewController {

    @IBOutlet weak var textUserName: BizGadgetTextField!
    @IBOutlet weak var textEmailAddress: BizGadgetTextField!
    @IBOutlet weak var textMobileNo: BizGadgetTextField!
    @IBOutlet weak var textUploadPhoto: BizGadgetTextField!
    @IBOutlet weak var textImgProfile: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleImage()
    }

    func circleImage()  {
        
        imgProfile?.layer.cornerRadius = (imgProfile?.frame.size.width ?? 0.0) / 2
        imgProfile?.clipsToBounds = true
        imgProfile?.layer.borderWidth = 3.0
        imgProfile?.layer.borderColor = UIColor.white.cgColor
        self.picker.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnProfile(_ sender: UIButton) {
        
        let alertAction = UIAlertController(title: "Select image from", message: nil, preferredStyle: .actionSheet)
        
        alertAction.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            handler in
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                self.picker.allowsEditing = true
                self.picker.sourceType = .camera
                self.picker.cameraCaptureMode = .photo
                self.present(self.picker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }))
        alertAction.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {
            handler in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                self.picker.allowsEditing = true
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true, completion: nil)
            }
        }))
        alertAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            handler in
            
        }))
        self.present(alertAction, animated: true, completion: nil)
    }
    
    
    @IBAction func textRegister(_ sender: BizGadgetButton) {
        if validatinSignUp() {
            print("Done .......")
            //
            Webservices.shared.SignUpConsumer(user_name: self.textUserName.text ?? " ",
                                              email: self.textEmailAddress.text ?? " ",
                                              password: " ",
                                              mobile: self.textMobileNo.text ?? " ",
                                              type: USER_OWNER,
                                              latitude: "",
                                              longitude: "",
                                              accuracy: ACCURACY,
                                              tags: [" "," "," "],
                                              success: {
                                                cussess in
                                                
            }, failure: {
                error in 
            })
        }
    }
    
    func validatinSignUp() -> Bool {
        
        if (textUserName.text?.isEmpty)! {
            Alert.showAlert(message: "Enter UserName", viewController: self)
            return false
        }
        if (textEmailAddress.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Email Address", viewController: self)
            return false
        }
        if (textMobileNo.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Mobile Number", viewController: self)
            return false
        }
        return true
    }

}


extension SignUpCustomerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imgProfile.image = chosenImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

