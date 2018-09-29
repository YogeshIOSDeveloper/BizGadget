//
//  GlobalData.swift
//  BizGadget
//
//  Created by Yogesh Date on 23/09/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class GlobalData: NSObject {
    
    static var shared : GlobalData = {
        var gloablData = GlobalData()
        
        return gloablData
    }()
    
    var user:User?

   func saveUser(obj : User?) {
        
        let defaults = UserDefaults.standard
        defaults.set(obj?.user_id,                        forKey: "user_id")
        defaults.setValue(obj?.user_name,                 forKey: "user_name")
        defaults.setValue(obj?.email,                     forKey: "email")
        defaults.setValue(obj?.mobile,                    forKey: "mobile")
        defaults.setValue(obj?.type,                      forKey: "type")
        defaults.setValue(obj?.authkey,                   forKey: "authkey")
        defaults.setValue(obj?.latitude,                  forKey: "latitude")
        defaults.setValue(obj?.longitude,                 forKey: "longitude")
        defaults.setValue(obj?.accuracy,                  forKey: "accuracy")
        defaults.setValue(obj?.business_name,             forKey: "business_name")
        defaults.setValue(obj?.business_owner_first_name, forKey: "business_owner_first_name")
        defaults.setValue(obj?.business_owner_last_name,  forKey: "business_owner_last_name")
        defaults.setValue(obj?.business_address,          forKey: "business_address")
        defaults.setValue(obj?.business_mobile,           forKey: "business_mobile")
        defaults.set(obj?.tags,                           forKey: "tags")
    
        self.user = obj
    }

    func displayUser() -> User? {
        let defaults = UserDefaults.standard
        
        user?.user_id                     = defaults.integer(forKey:"user_id")
        user?.user_name                   = defaults.string(forKey:"user_name")
        user?.email                       = defaults.string(forKey: "email")
        user?.mobile                      = defaults.string(forKey: "mobile")
        user?.type                        = defaults.string(forKey: "type")
        user?.authkey                     = defaults.string(forKey: "authkey")
        user?.latitude                    = defaults.string(forKey: "latitude")
        user?.longitude                   = defaults.string(forKey: "longitude")
        user?.accuracy                    = defaults.string(forKey: "accuracy")
        user?.business_name               = defaults.string(forKey: "business_name")
        user?.business_owner_first_name   = defaults.string(forKey: "business_owner_first_name")
        user?.business_owner_last_name    = defaults.string(forKey: "business_owner_last_name")
        user?.business_address            = defaults.string(forKey: "business_address")
        user?.business_mobile             = defaults.string(forKey: "business_mobile")

        return user
    }
    
    /*
    func deleteUserinfo() {
        let userObj = UserDefaults.standard
        let dictionary = userObj.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userObj.removeObject(forKey: key)
        }
    }
    */
    
}
