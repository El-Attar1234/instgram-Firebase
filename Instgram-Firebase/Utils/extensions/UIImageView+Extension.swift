//
//  UIImageView+Extension.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/3/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import  SDWebImage
extension UIImageView{
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    
    
    
    func downloadImage(url:String){
           self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "add-profile-image"))
       }
}
