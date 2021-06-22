//
//  Firebase+Extension.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 21/06/2021.
//  Copyright © 2021 ITI. All rights reserved.
//

import Foundation
import Firebase

extension Database{
    static func getUserWithID(uid : String , completion:@escaping([String : Any]?)->()){
        
             Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
              guard let dictionary = snapshot.value as? [String : Any] else {return}
                 completion(dictionary)
             }) { (error) in
                completion(nil)
                 print("failed to fetch user data")
             }
    }
}
