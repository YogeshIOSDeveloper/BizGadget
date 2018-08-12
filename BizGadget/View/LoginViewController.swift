//
//  LoginViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 12/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textUserName: BizGadgetTextField!
    @IBOutlet weak var textPassword: BizGadgetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationController?.navigationBar.isHidden = true
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
    
    @IBAction func btnSignInClicked(_ sender: BizGadgetButton) {
        
    }

    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "segueSignUp", sender: nil)
    }
    

}
