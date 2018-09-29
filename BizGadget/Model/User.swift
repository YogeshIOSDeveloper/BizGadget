//
//  User.swift
//  BizGadget
//
//  Created by Yogesh Date on 25/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    
    var result: Bool?
    var Response:UserRes?
    var message: String?
    var image: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case Response = "response"
        case result = "result"
        case message = "message"
    }
}

struct UserRes: Decodable {
    
    var userExist: Bool?
    var user: User?
    private enum CodingKeys: String, CodingKey {
        case userExist = "user_exist"
        case user = "user_data"
    }
}

struct User: Decodable {
    var user_id:Int
    var user_name:String?
    var email:String?
    var mobile:String?
    var type:String?
    var authkey:String?
    var latitude:String?
    var longitude:String?
    var accuracy:String?
    var business_name:String?
    var business_owner_first_name:String?
    var business_owner_last_name:String?
    var business_address:String?
    var business_mobile:String?
    var tags:[String]?
}



