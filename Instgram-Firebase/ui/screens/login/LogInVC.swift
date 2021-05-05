//
//  LogInVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/5/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func singUpShowScreen(_ sender: Any) {
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    

}
