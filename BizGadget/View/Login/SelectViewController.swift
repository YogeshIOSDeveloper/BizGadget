//
//  SelectViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit


protocol SelectUserDelegate {
    func didSelectUser(user: String)
}

class SelectViewController: UIViewController {

    @IBOutlet weak var switchCustomer: UISwitch!
    @IBOutlet weak var switchBusiness: UISwitch!
    
    var user: String?
    var SelectedUser:SelectUserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = USER_CUSTOMER
        switchBusiness.setOn(false, animated: true)
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
    
    
    @IBAction func btnCustomer(_ sender: UISwitch) {
        user = USER_OWNER
        switchCustomer.setOn(false, animated: true)
        switchBusiness.setOn(true, animated: true)
    }
    
    @IBAction func btnBusiness(_ sender: UISwitch) {
        user = USER_CUSTOMER
        switchBusiness.setOn(false, animated: true)
        switchCustomer.setOn(true, animated: true)
    }
    
    @IBAction func btnGoClicked(_ sender: BizGadgetButton) {
         self.dismiss(animated: true, completion: nil)
        SelectedUser?.didSelectUser(user: user ?? " ")
    }
    
}
