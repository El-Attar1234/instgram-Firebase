//
//  UIImageView+Extension.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/3/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import  SDWebImage

 fileprivate var lastUrlUsed : String?
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
    
   
    func downloadImageUsingSession(url:String){
        lastUrlUsed = url
           guard let url = URL(string: url) else {return}
               URLSession.shared.dataTask(with: url) { (data, response, error) in
                   if let error = error {
                       print("failed due to ",error)
                   }
                   if url.absoluteString != lastUrlUsed {
                       //to prevent repeating as urlsession works asynchronous
                     //  return
                   }
                   
                   guard let imageData = data else {return}
                   let photo = UIImage(data: imageData)
                   DispatchQueue.main.async {
                       self.image = photo
                   }
        }.resume()
    
}
}
