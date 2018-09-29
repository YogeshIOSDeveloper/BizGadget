//
//  FavouriteList.swift
//  BizGadget
//
//  Created by Yogesh Date on 29/09/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import Foundation






//"result": true,
//"list"

struct FavouriteRes:Decodable {
    var result:Bool?
    var list:[Favourite]?
}
struct Favourite:Decodable {
    var created_at:String?
    var id:Int?
    var name:String?
    var updated_at:String?
    var user_id:Int?
}

