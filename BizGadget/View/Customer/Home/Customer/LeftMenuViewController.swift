//
//  LeftMenuViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 15/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {

 //   @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customer
//        mainView.layer.shadowOpacity = 0.8
//        mainView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        mainView.layer.shadowRadius = 0.0
//
//        let shadowRect: CGRect = mainView.bounds.insetBy(dx: 5, dy: 5)
//        mainView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.view.addGestureRecognizer(gesture)
    }

    @objc func someAction(_ sender:UITapGestureRecognizer){
         NotificationCenter.default.post(name: NOTIFICATION_MENU, object: nil)
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
    // Customer
    @IBAction func btnLeftMenu(_ sender: UIButton) {
         NotificationCenter.default.post(name: NOTIFICATION_MENU, object: nil)
    }
    
    @IBAction func btnProfileClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_PROFILE, object: nil)
    }
    
    @IBAction func btnFeedsClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_FEEDBACK, object: nil)
    }
    
    @IBAction func btnAboutBizGadgetClicked(_ sender: UIButton) {
      NotificationCenter.default.post(name: NOTIFICATION_ABOUT, object: nil)
    }
    
    @IBAction func btnContactUsClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_CONTACT, object: nil)
    }
    
    @IBAction func btnHowItWorksClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_WORK, object: nil)
    }
    
    @IBAction func btnTermsOnCondition(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_CONDITION, object: nil)
    }
    
    @IBAction func btnPrivacyPolicy(_ sender: UIButton) {
        NotificationCenter.default.post(name: NOTIFICATION_POLICY, object: nil)
    }
    
    @IBAction func btnLogOutClicked(_ sender: UIButton) {
       let alertController = UIAlertController(title: "Logout",
                                               message: "Are you sure?",
                                               preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .default,
                                                handler: {
          handler in
          NotificationCenter.default.post(name: NOTIFICATION_MENU, object: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: {
          handler in
         NotificationCenter.default.post(name: NOTIFICATION_MENU, object: nil)
         NotificationCenter.default.removeObserver(NOTIFICATION_MENU)
         self.dismiss(animated: true, completion: nil)
        }))
        
       present(alertController, animated: true, completion: nil)
    }//
    
}
