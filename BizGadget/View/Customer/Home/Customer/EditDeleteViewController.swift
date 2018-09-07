//
//  EditDeleteViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 20/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

protocol SelectedOptionDelegate {
    func didSelectedOption(name:String, index:Int)
}

class EditDeleteViewController: UIViewController {

    var index:Int?
    var SelectedDelegate: SelectedOptionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func btnEditProfile(_ sender: UIButton) {
        self.SelectedDelegate?.didSelectedOption(name: ACTION_EDIT, index: index ?? -1)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDeleteProfileClicked(_ sender: UIButton) {
        self.SelectedDelegate?.didSelectedOption(name: ACTION_DELETE, index: index ?? -1)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
