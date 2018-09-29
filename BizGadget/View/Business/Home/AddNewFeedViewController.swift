//
//  AddNewFeedViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 08/09/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class AddNewFeedViewController: UIViewController {

    @IBOutlet weak var textTitle: BizGadgetTextField!
    @IBOutlet weak var textDetails: UITextView!
    @IBOutlet weak var textCategory: BizGadgetTextField!
    @IBOutlet weak var textUploadLogo: BizGadgetTextField!
    @IBOutlet weak var textUploadPhoto: BizGadgetTextField!
    @IBOutlet weak var textDate: BizGadgetTextField!
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var imaheProductPhoto: UIImageView!
    
    var photoLib:String?
    let imagePicker=UIImagePickerController()
    
    var aryCategory:[category_data]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    @IBAction func btnCategoryClicked(_ sender: Any) {
        
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ListDelegateViewController") as! ListDelegateViewController
        objVC.SelectedList = self
        let defaults = UserDefaults.standard
        let myarray = defaults.stringArray(forKey: "tags") ?? [String]()
        objVC.aryList = myarray
        self.present(objVC, animated: true, completion: nil)
    }
    
    @IBAction func btnUploadLogo(_ sender: UIButton) {
        self.selectImage(type: "LOGO")
    }
    
    @IBAction func btnUploadPhoto(_ sender: UIButton) {
        self.selectImage(type: "PHOTO")
    }
    
    @IBAction func btnDateClicked(_ sender: UIButton) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "DateDelegateViewController") as! DateDelegateViewController
        objVC.dateDelegate = self
        self.present(objVC, animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitClicked(_ sender: BizGadgetButton) {
       
        let userID = UserDefaults.standard.integer(forKey:"user_id")
        print("userID =\(userID)")
        Webservices.shared.createNewFeed(title: self.textTitle.text ?? " ",
                                         detail: self.textDetails.text ?? " ",
                                         category: self.textCategory.text ?? " ",
                                         date: self.textDate.text ?? " ",
                                         latitude: "18.654933",
                                         longitude: "73.80768",
                                         accuracy: 15,
                                         user_id: userID,
                                         logo: self.imageLogo.image!,
                                         image: self.imaheProductPhoto.image!,
                                         success: {
                                            success in
                                            
        }, failure: {
            error in
        })
    }
    
    @IBAction func btnCancelClicked(_ sender: BizGadgetButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK :- Function ImagePicker
    func selectImage(type:String)  {
        self.photoLib = type
        let alert = UIAlertController(title: "Chose Media", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo",
                                      style: UIAlertActionStyle.default,
                                      handler: {
                                        alert in
                                        self.takePhoto()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery",
                                      style: .default,
                                      handler: {
                                        alert in
                                        self.selectGallery()
                                        
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: {
                                        alert in
                                        
                                        
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

    func selectGallery()  {
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            Alert.showAlert(message: "Camera not found", viewController: self)
        }
    }

}

extension AddNewFeedViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if self.photoLib == "LOGO"{
               self.imageLogo.image = pickedImage
            }
            if self.photoLib == "PHOTO"{
                self.imaheProductPhoto.image = pickedImage
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension AddNewFeedViewController: SelectedListDelegate {
    func didSelectedIndexPath(index: Int, name: String) {
        self.textCategory.text = name
    }
    
}

extension AddNewFeedViewController: DisplayDateDelegate {
    func didSelectedDate(date : String) {
        self.textDate.text = date
    }
}
