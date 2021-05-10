//
//  Post.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/10/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import Foundation
 
struct Post {
    let imageUrl : String
    let caption  : String
    init(dictionary : [String : Any]) {
        self.imageUrl = dictionary["image_Url"] as? String ?? ""
        self.caption  = dictionary["caption"]  as? String ?? ""
        
    }
}
