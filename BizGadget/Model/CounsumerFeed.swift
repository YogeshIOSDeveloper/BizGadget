//
//  CounsumerFeed.swift
//  BizGadget
//
//  Created by Yogesh Date on 23/09/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import Foundation

struct FeedResponse: Decodable {
    var result:Bool?
    var list:[Feed]?
}

struct Feed:Decodable {
    var id:Int?
    var title:String?
    var detail:String?
    var logo:String?
    var date:String?
    var latitude:String?
    var longitude:String?
    var accuracy:String?
    var category:String?
    var email:String?
    var number:String?
    var images:[Images]?
    
}

struct Images:Decodable {
    var id:Int?
    var url:String?
}

