//
//  MainTabBarController.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/2/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
       super.viewDidLoad()
        view.backgroundColor = .red
        
     //   let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewLayout())
        
          let userProfileVC = UserProfileViewController()
        let navController = UINavigationController(rootViewController: userProfileVC)
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .green
        // UITabBar.appearance().tintColor = .black
//tabBar.tintColor = .black
        
        self.viewControllers = [navController , vc1]
    }
}
