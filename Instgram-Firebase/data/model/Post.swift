//
//  Post.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/10/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import Foundation
 
struct Post {
    let user : User
    let imageUrl : String
    let caption  : String
    init(user : User ,dictionary : [String : Any]) {
        self.user = user
        self.imageUrl = dictionary["image_Url"] as? String ?? ""
        self.caption  = dictionary["caption"]  as? String ?? ""
        
    }
}
