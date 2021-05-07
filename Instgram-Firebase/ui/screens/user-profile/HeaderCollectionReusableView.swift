//
//  HeaderCollectionReusableView.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/3/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet private weak var userProfileImage: UIImageView!
    
    func setUpComponent(imageURL : String?){
       userProfileImage.makeRounded()
        userProfileImage.downloadImage(url: imageURL ?? "")
    }
    
    
    
}
