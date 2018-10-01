//
//  SignUpCustomerViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import CoreLocation

class SignUpCustomerViewController: UIViewController {

    @IBOutlet weak var textUserName: BizGadgetTextField!
    @IBOutlet weak var textEmailAddress: BizGadgetTextField!
    @IBOutlet weak var textMobileNo: BizGadgetTextField!
    @IBOutlet weak var textPassword: BizGadgetTextField!    
    @IBOutlet weak var textConfirmPwd: BizGadgetTextField!
    @IBOutlet weak var textTag: BizGadgetTextField!

    
    var locationManager:CLLocationManager!
    var lat:Double?
    var long:Double?
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
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
            let str = self.textTag.text ?? " "
            var arrayString = str.components(separatedBy: " ")
            if arrayString.last == "" {
               arrayString.removeLast()
            }
            print("Ary String =\(arrayString)")
            PROGRESS_SHOW(view: self.view)
            Webservices.shared.SignUpConsumer(user_name: self.textUserName.text ?? " ",
                                              email: self.textEmailAddress.text ?? " ",
                                              password: self.textPassword.text ?? " ",
                                              mobile: self.textMobileNo.text ?? " ",
                                              type: USER_CUSTOMER,
                                              latitude: self.lat ?? 0,
                                              longitude: self.long ?? 0,
                                              accuracy: ACCURACY,
                                              tags: arrayString,
                                              success: {
                                                objUser in
                                                self.checkUserResponse(user: objUser)
                                                PROGRESS_HIDE()
                                                
            }, failure: {
                error in
                PROGRESS_ERROR(view: self.view, error: error)
            })
        }
    }
    
    
    // MARK :- User Response
    func checkUserResponse(user : User)  {
        
        print(user.user_name as Any )
        GlobalData.shared.saveUser(obj: user)
        performSegue(withIdentifier: "segueCustomer", sender: nil)
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
        if (textPassword.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Password", viewController: self)
            return false
        }
        if (textConfirmPwd.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Confirm Password", viewController: self)
            return false
        }
        if !(textPassword?.text == textConfirmPwd?.text) {
            Alert.showAlert(message: "Password And Confirm Password not match", viewController: self)
            return false
        }
        if (textTag.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Tags", viewController: self)
            return false
        }
        return true
    }

}


extension SignUpCustomerViewController:CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        self.lat = userLocation.coordinate.latitude
        self.long = userLocation.coordinate.longitude
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
