//
//  UIView+Extension.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 4/28/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

extension UIView{
    
    func anchor(top : NSLayoutYAxisAnchor?, topPadding : CGFloat,bottom : NSLayoutYAxisAnchor?,bottomPadding : CGFloat,leading :NSLayoutXAxisAnchor?,leadingPadding : CGFloat,trailing :NSLayoutXAxisAnchor? ,trailingPadding : CGFloat, width :CGFloat? , height :CGFloat?){
        
         self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        func makeRounded() {
            self.layer.borderWidth = 1
            self.layer.masksToBounds = true
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = self.frame.height / 2
           // self.clipsToBounds = true
        }
        

    }
    
}

