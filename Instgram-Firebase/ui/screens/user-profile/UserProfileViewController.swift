//
//  UserProfileViewController.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/3/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userProfileCollectionView: UICollectionView!
    var imageURL : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title =   Auth.auth().currentUser?.uid ?? "User Profile"
        navigationController?.tabBarItem.image = UIImage(systemName: "person")
        navigationController?.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        tabBarController?.tabBar.tintColor = .black
        tabBarController?.tabBar.barTintColor = .lightGray
        fetchUserData()
        
    }
    
    
    
    
    
}
extension UserProfileViewController :UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        header.backgroundColor = .red
        header.setUpComponent(imageURL : imageURL)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    fileprivate func fetchUserData(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            guard let self = self else {return}
            guard let dictionary = snapshot.value as? [String : Any] else {return}
            let userName = dictionary["userName"] as? String
            let imageURL = dictionary["image_Url"] as? String
            self.imageURL = imageURL ?? ""
            print("thread ->>>>\(Thread.current)")
            print("thread ->>>>\(Thread.isMainThread)")
            self.navigationItem.title = userName
            self.userProfileCollectionView.reloadData()
        }) { (error) in
            print("failed to fetch user data")
        }
        
    }
    
    
}


struct UIHelper{
    
    static func createThreeColumnFlowLayout(in view:UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    //may be put in networkManager
    static let cache=NSCache<NSString,UIImage>()
}
