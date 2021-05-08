//
//  HomeVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/8/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
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
