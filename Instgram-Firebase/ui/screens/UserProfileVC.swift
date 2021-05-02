//
//  UserProfileVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/2/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        navigationItem.title =   Auth.auth().currentUser?.uid ?? "User Profile"
        
        navigationController?.tabBarItem.image = UIImage(systemName: "person")
        navigationController?.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        tabBarController?.tabBar.tintColor = .black
        tabBarController?.tabBar.barTintColor = .lightGray
        fetchUserData()
    }
    
    fileprivate func fetchUserData(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            guard let self = self else {return}
            guard let dictionary = snapshot.value as? [String : Any] else {return}
            let userName = dictionary["userName"] as? String
            self.navigationItem.title = userName
        }) { (error) in
            print("failed to fetch user data")
        }
        
    }
    
    
    
}

