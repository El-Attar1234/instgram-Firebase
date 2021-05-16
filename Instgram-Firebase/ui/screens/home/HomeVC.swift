//
//  HomeVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/8/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    @IBOutlet weak var postsCollectionView: UICollectionView!
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        setUpNavigationTitle()
        self.fetchUserPosts()
    }
    
    fileprivate func setUpNavigationTitle(){
        let image: UIImage = UIImage(named: "title-logo")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
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
                        
                        self.postsCollectionView.reloadData()
                    }
                }
                
            }) { (error) in
                print("failed due to", error)
            }
        }
        
    }
    
    
}

extension HomeVC : UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("\(viewController)")
        if viewController is PhotoSelectorVC{
            let vc = self.storyboard?.instantiateViewController(identifier: "PhotoSelectorVC") as! PhotoSelectorVC
            
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
            return false
        }
        
        return true
    }
    
}
