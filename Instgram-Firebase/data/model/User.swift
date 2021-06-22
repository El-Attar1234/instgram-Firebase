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
    let uid : String
    init(uid:String,dictionary : [String : Any]) {
        self.userName = dictionary["userName"] as? String ?? ""
        self.profileImage = dictionary["image_Url"] as? String ?? ""
        self.uid = uid
    }
}
protocol Test {
    associatedtype y
    func add()->y
}

class x: Test {
    typealias y = Int
    func add() -> y {
        return 10
    }
  //
    
    
}
