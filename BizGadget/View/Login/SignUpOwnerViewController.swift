//
//  SignUpViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import CoreLocation

class SignUpOwnerViewController: UIViewController {

    @IBOutlet weak var textUserName: BizGadgetTextField!
    @IBOutlet weak var textEmail: BizGadgetTextField!
    @IBOutlet weak var textPassword: BizGadgetTextField!
    @IBOutlet weak var textMobileNo: BizGadgetTextField!
    @IBOutlet weak var textBussinessName: BizGadgetTextField!
    @IBOutlet weak var textFirstName: BizGadgetTextField!
    @IBOutlet weak var textLastName: BizGadgetTextField!
    @IBOutlet weak var textAddress: UITextView!
    @IBOutlet weak var textBussinessNumber: BizGadgetTextField!
    @IBOutlet weak var textTag: BizGadgetTextField!
    
    var locationManager:CLLocationManager!
    var lat:Double?
    var long:Double?
    private var picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textAddress.text = "Business Address"
        textAddress.textColor = UIColor.lightGray
        textAddress.delegate = self //UITextViewDelegate
        determineMyCurrentLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            print("Done .......")
            let str = self.textTag.text ?? " "
            var arrayString = str.components(separatedBy: " ")
            if arrayString.last == "" {
                arrayString.removeLast()
            }
            
//            Webservices.shared.SignUpBusiness(user_name: self.textUserName.text ?? " ",
//                                              email: self.textEmail.text ?? " ",
//                                              password: self.textPassword.text ?? " ",
//                                              mobile: self.textEmail.text ?? " ",
//                                              type: USER_OWNER,
//                                              business_name: self.textBussinessName.text ?? " ",
//                                              business_owner_first_name: self.textFirstName.text ?? " ",
//                                              business_owner_last_name: self.textLastName.text ?? " ",
//                                              business_address: self.textAddress.text ?? " ",
//                                              business_mobile: self.textMobileNumber.text ?? " ",
//                                              latitude: "",
//                                              longitude: "",
//                                              accuracy: "15",
//                                              tags: ["chinese", "indian", "veg"],
//                                              image0: imageProfile.image!,
//                                              success: {
//                                                success in
//            }, failure: {
//                error in
//            })
//        }
            
            self.signUp(user_name: self.textUserName.text ?? " ",
                        email: self.textEmail.text ?? " ",
                        password: self.textPassword.text ?? " ",
                        mobile:  self.textEmail.text ?? " ",
                        business_name: self.textBussinessName.text ?? " ",
                        business_owner_first_name: self.textFirstName.text ?? " ",
                        business_owner_last_name: self.textLastName.text ?? " ",
                        business_mobile: self.textBussinessNumber.text ?? " ",
                        business_address: self.textAddress.text ?? " ",
                        latitude: self.lat ?? 0,
                        longitude: self.long ?? 0,
                        tags: arrayString)
            
        }
    }

    func signUp(user_name:String,
                email:String,
                password:String,
                mobile:String,
                business_name:String,
                business_owner_first_name:String,
                business_owner_last_name:String,
                business_mobile:String,
                business_address:String,
                latitude:Double,
                longitude:Double,
                tags:[String])  {
        
        PROGRESS_SHOW(view: self.view)
        let url = URL(string:"https://biz-gadget.herokuapp.com/api/commons/signup")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "user_name=\(user_name)&email=\(email)&password=\(password)&mobile=\(mobile)&type=business&business_name=\(business_name)&business_owner_first_name=\(business_owner_first_name)&business_owner_last_name=\(business_owner_last_name)&business_mobile=\(business_mobile)&business_address=\(business_address)&latitude=\(latitude)&longitude=\(longitude)&accuracy=15.00&tags=\(tags)"
        
        print("\n\n\n Post String =\(postString)")
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                
                DispatchQueue.main.async {
                    // check for fundamental networking error
                    print("error=\(error?.localizedDescription ?? "Error" )")
                    PROGRESS_ERROR(view: self.view, error: error?.localizedDescription ?? "Error")
                }
                return
            }
            DispatchQueue.main.async {
                do
                {
                    let responseString = String(data: data, encoding: .utf8)
                    print("responseString = \(responseString ?? "Nil")")
                    
                    let userData = try JSONDecoder().decode(UserData.self, from: data)
                    if userData.result ?? false {
                        PROGRESS_HIDE()
                        self.checkUserResponse(user: (userData.Response?.user)!)
                    } else {
                        PROGRESS_ERROR(view: self.view, error: userData.message ?? "Error")
                    }
                }
                catch {
                    PROGRESS_ERROR(view: self.view, error: "JSON Error")
                }
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString ?? "Nil")")
            }
        }
        task.resume()
    }
    
    // MARK :- User Response
    func checkUserResponse(user : User)  {
        
        print(user.user_name as Any )
        GlobalData.shared.saveUser(obj: user)
        performSegue(withIdentifier: "segueOwner", sender: nil)
        
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
        if (textBussinessNumber.text?.isEmpty)!{
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


extension SignUpOwnerViewController:CLLocationManagerDelegate {
    
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
