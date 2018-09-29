//
//  Category.swift
//  BizGadget
//
//  Created by Yogesh Date on 07/09/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import Foundation

struct CategoryResponse: Decodable {
    var result: Bool?
    var message: String?
    var response: response?
}
struct response: Decodable {
    var category:Bool?
    var category_data: [category_data]?
}
struct category_data:Decodable {
    var id: Int?
    var name: String?
}
