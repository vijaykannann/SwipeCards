//
//  CardsModel.swift
//  SwipeCards
//
//  Created by VJ's iMAC on 22/09/20.
//  Copyright © 2020 VJ's. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct Cards: Mappable {
    
    var id : String?
    var text: String?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.text <- map["text"]

    
    }
    
}

