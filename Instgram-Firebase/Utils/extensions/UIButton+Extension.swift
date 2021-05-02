//
//  UIButton+Extension.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/1/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

extension UIButton{
    func makeRounded() {
               self.layer.borderWidth = 3
              // self.layer.masksToBounds = true
               self.layer.borderColor = UIColor.black.cgColor
               self.layer.cornerRadius = self.frame.width / 2
               self.clipsToBounds = true
           }
}
