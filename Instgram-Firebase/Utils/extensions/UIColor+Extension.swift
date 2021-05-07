//
//  UIColor+Extension.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 4/28/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

extension UIColor{
    
    static func colorWithRGB(red: CGFloat, green:CGFloat, blue: CGFloat)->UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
