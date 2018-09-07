//
//  LeftViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 18/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Owner
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Left Mene // Owner
    @objc func someAction(_ sender:UITapGestureRecognizer){
        NotificationCenter.default.post(name: NOTIFICATION_MENU_OWNER, object: nil)
    }
    
    @IBAction func btnCrossCLicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_MENU_OWNER, object: nil)
    }

    @IBAction func btnProfileClicked(_ sender: UIButton) { 
        NotificationCenter.default.post(name: NOTIFICATION_PROFILE_OWNER, object: nil)
    }
    
    @IBAction func btnFeedsClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_FEEDBACK_OWNER, object: nil)
    }
    
    @IBAction func btnAboutBizGadgetClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_ABOUT_OWNER, object: nil)
    }
    
    @IBAction func btnContactUsClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_CONTACT_OWNER, object: nil)
    }
    
    @IBAction func btnHowItWorksClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_WORK_OWNER, object: nil)
    }
    
    @IBAction func btnTermsOnCondition(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_CONDITION_OWNER, object: nil)
    }
    
    @IBAction func btnPrivacyPolicy(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_POLICY_OWNER, object: nil)
    }
    
    @IBAction func btnLogOutClicked(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Logout",
                                                message: "Are you sure?",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .default,
                                                handler: {
                                                    handler in
        NotificationCenter.default.post(name: NOTIFICATION_MENU_OWNER, object: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: {
              handler in
              NotificationCenter.default.post(name: NOTIFICATION_MENU_OWNER, object: nil)
              NotificationCenter.default.removeObserver(NOTIFICATION_MENU_OWNER)
              self.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }//
}
