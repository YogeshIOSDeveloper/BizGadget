//
//  BigzGadgetImage.swift
//  BizGadget
//
//  Created by Yogesh Date on 15/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class BigzGadgetImage: UIImageView {

    @IBInspectable var borderWidth : CGFloat {
        set {
             layer.borderWidth = newValue
        }
        get {
            return self.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor : UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    private var _round = false
    @IBInspectable var round: Bool {
        set {
            _round = newValue
            makeRound()
        }
        get {
            return self._round
        }
    }
    override internal var frame: CGRect {
        set {
            super.frame = newValue
            makeRound()
        }
        get {
            return super.frame
        }
        
    }
    
    private func makeRound() {
        if self.round == true {
            self.clipsToBounds = true
            self.layer.cornerRadius = (self.frame.width + self.frame.height) / 4
        } else {
            self.layer.cornerRadius = 0
        }
    }
    
    override func layoutSubviews() {
        makeRound()
    }
}
