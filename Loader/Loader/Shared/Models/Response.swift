//
//  Response.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/11/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

struct Response: Decodable {
    
    let ans: String?
    let num: Int?
    let sh: String?
    let html: String?
    
    enum CodingKeys: String, CodingKey {
        case ans
        case num
        case sh
        case html = "HTML"
    }
}
