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
    @IBOutlet weak var editProfileButton: UIButton!
    
    @IBOutlet weak var userName: UILabel!
    var isFollowed = false
    var user : User?{
        didSet{
            userProfileImage.makeRounded()
            userProfileImage.downloadImage(url: user?.profileImage ?? "")
            userName.text = user?.userName ?? ""
            
        }
    }
    var target : Target?{
        didSet{
            switch target {
            case .Search:
                editProfileButton.setTitle("Follow", for: .normal)
                editProfileButton.backgroundColor = UIColor.colorWithRGB(red: 149, green: 204, blue: 255)
            default:
                editProfileButton.setTitle("Edit Profile", for: .normal)
            }
        }
    }
    @IBAction func editProfileButtonAction(_ sender: Any) {
        isFollowed.toggle()
        switch target {
        case .Search:
            if isFollowed{
                editProfileButton.setTitle("UnFollow", for: .normal)
                editProfileButton.backgroundColor = UIColor.colorWithRGB(red: 149, green: 204, blue: 255)
            }
            else{
                editProfileButton.setTitle("Follow", for: .normal)
                editProfileButton.backgroundColor = UIColor.colorWithRGB(red: 149, green: 204, blue: 255)
            }
        default:
            break
        }
    }
    
    
    
    
}
