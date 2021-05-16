//
//  User.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/16/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import Foundation
 
struct User{
    let userName : String
    let profileImage : String
    init(dictionary : [String : Any]) {
        self.userName = dictionary["userName"] as? String ?? ""
        self.profileImage = dictionary["image_Url"] as? String ?? ""
    }
}
