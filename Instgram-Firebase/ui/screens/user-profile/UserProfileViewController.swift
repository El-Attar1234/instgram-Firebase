//
//  UserProfileViewController.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/3/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Firebase

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}





class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var userProfileCollectionView: UICollectionView!
    var imageURL : String?
    var posts = [Post]()
    override func viewDidLoad() {
        checkIfUserIsLogin()
        super.viewDidLoad()
        navigationItem.title =   Auth.auth().currentUser?.uid ?? "User Profile"
        fetchUserData()
        fetchOrderedUserPosts()
        //  tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: -4)
        //   fetchUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetchUserData()
        // fetchUserPosts()
    }
    fileprivate func checkIfUserIsLogin(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginNavController = self.storyboard?.instantiateViewController(identifier: "LogInNavController") as! UINavigationController
                loginNavController.modalPresentationStyle = .fullScreen
                self.present(loginNavController, animated: true, completion: nil)
            }
            return
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive,handler: {(_) in
            try?Auth.auth().signOut()
            let loginNavController = self.storyboard?.instantiateViewController(identifier: "LogInNavController") as! UINavigationController
            loginNavController.modalPresentationStyle = .fullScreen
            self.present(loginNavController, animated: true, completion: nil)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,handler:nil)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        self.present(alertController , animated: true ,completion: nil)
    }
    
    
    
    var user : User?
    func fetchUserData(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        
        
        // DispatchQueue.global(qos: .background).async {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            guard let self = self else {return}
            guard let dictionary = snapshot.value as? [String : Any] else {return}
            let user = User(dictionary: dictionary)
            self.user = user
            self.imageURL = user.profileImage
            // navigationItem.title =   userName
            //  DispatchQueue.main.async {
            self.navigationItem.title = user.userName
            self.userProfileCollectionView.reloadData()
            //}
            
        }) { (error) in
            print("failed to fetch user data")
        }
        //}
        
        
    }
    fileprivate func fetchOrderedUserPosts(){
        DispatchQueue.global(qos: .background).async {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let userPostRef =  Database.database().reference().child("posts").child(uid)
            userPostRef.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { [weak self](snapShot) in
                guard let self = self else {return}
                guard let dictionary = snapShot.value as? [String : Any] else {return}
                //   let user = User(dictionary: dictionary)
                guard let user = self.user else {return}
                let post = Post(user : user , dictionary: dictionary)
                self.posts.insert(post, at: 0)
                //self.posts.append(post)
                DispatchQueue.main.async {
                    
                    self.userProfileCollectionView.reloadData()
                }
                
                
            }) { (error) in
                print("failed due to", error)
            }
        }
    }
    
    /*
     fileprivate func fetchUserPosts(){
     DispatchQueue.global(qos: .background).async {
     guard let uid = Auth.auth().currentUser?.uid else {return}
     let userPostRef =  Database.database().reference().child("posts").child(uid)
     userPostRef.observeSingleEvent(of: .value, with: { [weak self](snapShot) in
     guard let self = self else {return}
     guard let dictionaries = snapShot.value as? [String : Any] else {return}
     dictionaries.forEach { (key: String, value: Any) in
     guard let dictionary = value as? [String : Any] else {return}
     let post = Post(dictionary: dictionary)
     self.posts.append(post)
     DispatchQueue.main.async {
     
     self.userProfileCollectionView.reloadData()
     }
     }
     
     }) { (error) in
     print("failed due to", error)
     }
     }
     
     }*/
    
}


