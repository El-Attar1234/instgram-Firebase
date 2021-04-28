//
//  CustomTextField.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 4/26/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeHolder: String ) {
        super.init(frame: .zero)
        self.placeholder = placeHolder
        configure()
    }
    
    private func configure (){
   
               translatesAutoresizingMaskIntoConstraints=false
        backgroundColor = UIColor(white: 0, alpha: 0.1)
               //for text
               layer.cornerRadius          = 10
               layer.borderWidth           = 2
        layer.borderColor           = .init(srgbRed: 100/255, green: 100/255, blue: 100/255, alpha: 1)   //UIColor.systemGray4.cgColor
               borderStyle                = .roundedRect
               textColor                   = .black
               tintColor                   = .black
               textAlignment               = .left
               font                        = UIFont.preferredFont(forTextStyle: .title2)
               adjustsFontSizeToFitWidth   = true
               minimumFontSize             = 12
               returnKeyType               = .go
               autocorrectionType          = .no
              
    
    }
    
    
    
    
}
