//
//  ContainerViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 15/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var viewHome: UIView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var leftTriling: NSLayoutConstraint!
    @IBOutlet weak var leftWidth: NSLayoutConstraint!
    
    var isSideMenuOpen = false
    var width: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        width = self.viewHome.frame.size.width
        leftTriling.constant =  -CGFloat(width!)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSidemenu),
                                               name: NOTIFICATION_MENU,
                                               object: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func toggleSidemenu() {
        if isSideMenuOpen {
            leftTriling.constant = -CGFloat(width!)
        } else {
           leftTriling.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        isSideMenuOpen = !isSideMenuOpen
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
