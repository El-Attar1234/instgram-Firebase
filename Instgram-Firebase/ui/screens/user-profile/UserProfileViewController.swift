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
    override func viewDidLoad() {
        checkIfUserIsLogin()
        super.viewDidLoad()
        navigationItem.title =   Auth.auth().currentUser?.uid ?? "User Profile"
        navigationController?.tabBarItem.image = UIImage(systemName: "person")
        navigationController?.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        tabBarController?.tabBar.tintColor = .black
        tabBarController?.tabBar.barTintColor = .lightGray
        fetchUserData()
        
        
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
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,handler:nil)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        self.present(alertController , animated: true ,completion: nil)
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
        header.setUpComponent(imageURL : imageURL)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
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
