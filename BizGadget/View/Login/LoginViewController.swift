//
//  LoginViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 12/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var textUserName: BizGadgetTextField!
    @IBOutlet weak var textPassword: BizGadgetTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check user
        let defaults = UserDefaults.standard
        let myarray = defaults.stringArray(forKey: "tags") ?? [String]()
        for i in 0..<myarray.count {
            let name = myarray[i]
            print("name=\(name)")
        }
        
        let userTtype = UserDefaults.standard.string(forKey: "type")
        if let user = userTtype {
            if user == USER_OWNER {
                performSegue(withIdentifier: "segueOwner", sender: nil)
            }
            if user == USER_CUSTOMER {
                performSegue(withIdentifier: "segueCustomer", sender: nil)
            }
        } else {
            print("Login..... ")
        }
        
        let str = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        lblName.attributedText = addSeeMore(str: str, maxLength: 20)
    }
    
    func addSeeMore(str: String, maxLength: Int) -> NSAttributedString {
        var attributedString = NSAttributedString()
        let index: String.Index = str.index(str.startIndex, offsetBy: maxLength)
        let editedText = String(str.prefix(upTo: index)) + "... See More"
        attributedString = NSAttributedString(string: editedText)
        
        return attributedString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true // hide nav bar
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false // show nav bar to next screen
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
    
    
    // MARK: -  Button Event
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        
        let viewVC =  self.storyboard?.instantiateViewController(withIdentifier: "SelectViewController") as! SelectViewController
        viewVC.SelectedUser = self //SelectUserDelegate
        self.present(viewVC, animated: false, completion: nil)
    }
    
    @IBAction func btnSignInClicked(_ sender: BizGadgetButton) {

        if loginValidation() {
            PROGRESS_SHOW(view: self.view)
            Webservices.shared.Signin(username: self.textUserName.text ?? " ",
                                      password: self.textPassword.text ?? " ",
                                      success: {
                                        (user: User) in
                                        
                                        PROGRESS_HIDE()
                                        self.checkUserResponse(user: user)
                                        
            }, failure: {
                error in
                PROGRESS_ERROR(view: self.view, error: error)
            })
        }
    }

    // MARK :- User Response
    func checkUserResponse(user : User)  {
        
        print(user.user_name as Any )
        guard let userType = user.type else { return }
        GlobalData.shared.saveUser(obj: user)
        if userType == USER_OWNER {
            performSegue(withIdentifier: "segueOwner", sender: nil)
        } else {
            performSegue(withIdentifier: "segueCustomer", sender: nil)
        }
    }
    
    // MARK :- Validation
    func loginValidation() -> Bool{
        if (textUserName.text?.isEmpty)! {
            Alert.showAlert(message: "Enter UserName", viewController: self)
            return false
        }
        if (textPassword.text?.isEmpty)! {
            Alert.showAlert(message: "Enter Password", viewController: self)
            return false
        }
        return true
    }
    
    
    // MARK :- change text colot
    func textFieldColor() {
        self.textUserName.borderWidth = 1
        self.textUserName.borderColor = UIColor.red
        self.textPassword.borderWidth = 1
        self.textPassword.borderColor = UIColor.red
    }
    func textFieldClearColor() {
        self.textUserName.borderWidth = 0
        self.textUserName.borderColor = UIColor.clear
        self.textPassword.borderWidth = 0
        self.textPassword.borderColor = UIColor.clear
    }
    
}


// MARK :- SelectUserDelegate
extension LoginViewController : SelectUserDelegate {

    func didSelectUser(user: String) {
        print("User Type = \(user)")
        if user == USER_OWNER {
             performSegue(withIdentifier: "segueSignUp", sender: nil)
        } else {
            performSegue(withIdentifier: "segueCustomerSignUp", sender: nil)
        }
    }

}

