//
//  Constant.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import Foundation
import JGProgressHUD


let USER_CUSTOMER                = "consumer"
let USER_OWNER                   = "business"
let ACCURACY                     = 15
let ACTION_EDIT                  = "EDIT"
let ACTION_DELETE                = "DELETE"
let WEB_DEFAULT                  = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

//Notification customer
let NOTIFICATION_MENU            = NSNotification.Name(rawValue: "NOTIFICATION_MENU")
let NOTIFICATION_PROFILE         = NSNotification.Name(rawValue: "NOTIFICATION_PROFILE")
let NOTIFICATION_FEEDBACK        = NSNotification.Name(rawValue: "NOTIFICATION_FEEDBACK")
let NOTIFICATION_ABOUT           = NSNotification.Name(rawValue: "NOTIFICATION_ABOUT")
let NOTIFICATION_CONTACT         = NSNotification.Name(rawValue: "NOTIFICATION_CONTACT")
let NOTIFICATION_WORK            = NSNotification.Name(rawValue: "NOTIFICATION_WORK")
let NOTIFICATION_CONDITION       = NSNotification.Name(rawValue: "NOTIFICATION_CONDITION")
let NOTIFICATION_POLICY          = NSNotification.Name(rawValue: "NOTIFICATION_POLICY")
//Notification owner
let NOTIFICATION_MENU_OWNER      = NSNotification.Name(rawValue: "NOTIFICATION_MENU_OWNER")
let NOTIFICATION_PROFILE_OWNER   = NSNotification.Name(rawValue: "NOTIFICATION_PROFILE_OWNER")
let NOTIFICATION_FEEDBACK_OWNER  = NSNotification.Name(rawValue: "NOTIFICATION_FEEDBACK_OWNER")
let NOTIFICATION_ABOUT_OWNER     = NSNotification.Name(rawValue: "NOTIFICATION_ABOUT_OWNER")
let NOTIFICATION_CONTACT_OWNER   = NSNotification.Name(rawValue: "NOTIFICATION_CONTACT_OWNER")
let NOTIFICATION_WORK_OWNER      = NSNotification.Name(rawValue: "NOTIFICATION_WORK_OWNER")
let NOTIFICATION_CONDITION_OWNER = NSNotification.Name(rawValue: "NOTIFICATION_CONDITION_OWNER")
let NOTIFICATION_POLICY_OWNER    = NSNotification.Name(rawValue: "NOTIFICATION_POLICY_OWNER")
// Web Api
let WEB_API_URL                  = "https://biz-gadget.herokuapp.com/api/commons/"

// PROGRESS
let hudProgress = JGProgressHUD(style: .dark)
func PROGRESS_SHOW(view : UIView) {
    hudProgress.textLabel.text = "Please Wait..."
    hudProgress.show(in:view)
}
func PROGRESS_HIDE(){
    hudProgress.dismiss()
}
func PROGRESS_SUCCESS(view : UIView) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Success..... "
    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 3.0)
    PROGRESS_HIDE()
}
func PROGRESS_SUCCESS_PPATIENT(view : UIView) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Patient verify successfully..."
    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 3.0)
    PROGRESS_HIDE()
}
func PROGRESS_SUCCESS_MESSAGE(view : UIView,message:String) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = message
    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 3.0)
}
func PROGRESS_SUCCESS_HOME_MESSAGE(view : UIView,message:String) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = message
    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 1.0)
}
func PROGRESS_ERROR(view : UIView, error : String) {
    PROGRESS_HIDE()
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "\(error)"
    hud.indicatorView = JGProgressHUDErrorIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 3.0)
}
