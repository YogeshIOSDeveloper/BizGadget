//
//  Alert.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    public static func showAlert(message:String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action  in

        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
