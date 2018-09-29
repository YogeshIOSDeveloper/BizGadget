//
//  DateDelegateViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 29/09/18.
//  Copyright © 2018 Yogesh date. All rights reserved.


import UIKit

@objc protocol DisplayDateDelegate {
    func didSelectedDate(date : String)
    
}

class DateDelegateViewController: UIViewController {
    
    //UIViewController
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    //Variable
    var dateDelegate : DisplayDateDelegate?
    
    var formatedTime : String {
        let formater = DateFormatter()
        formater.dateStyle = .short
        formater.dateFormat = "yyy-MM-dd"    //"dd-MM-yyy" //"yyy-MM-dd"
        
        return formater.string(from: myDatePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /*
     *
     *
     *
     *
     *
     *
     *
     *
     *
     *
     *
     *
     *
     */
    // MARK: - UIController Event
    @IBAction func btn_Delete(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_Ok(_ sender: Any) {
        
        dateDelegate?.didSelectedDate(date:formatedTime)
        self.dismiss(animated: true, completion: nil)
    }
    
}

