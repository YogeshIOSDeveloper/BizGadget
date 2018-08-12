//
//  BizGadgetButton.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BizGadgetButton: UIButton {
    
    @IBInspectable
    var  cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    
    
    
}
